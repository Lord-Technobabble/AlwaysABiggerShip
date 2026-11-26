extends Node

const ARMOR_LOW_BOUND = 5
const ARMOR_HIGH_BOUND = 10
const WEAPON_LOW_BOUND = 2
const WEAPON_HIGH_BOUND = 11

func create_basic_ship() -> Ship:
	#We get a bag randomizer and put in the parts we want to create the ship from
	var bag = BagRandomizer.new()
	bag.put("armor", HelpfulFce.bounded_randi(ARMOR_LOW_BOUND, ARMOR_HIGH_BOUND))
	#bag.put("weapon", HelpfulFce.bounded_randi(WEAPON_LOW_BOUND, WEAPON_HIGH_BOUND))
	return create_ship_from_bag(bag)

func create_ship_from_bag(part_bag: BagRandomizer) -> Ship:
	var ship: Ship = preload("res://Scenes/ship.tscn").instantiate()
	ship.starting_core_scene = preload("res://Scenes/Components/default_core.tscn")
	
	while not part_bag.is_empty():
		var next_name = part_bag.grab()
		
		var component: Component = null
		match next_name:
			"armor":
				component = _create_armor()
			"weapon":
				component = _create_weapon()
				
		if component == null:
			push_warning("Tried to create an unknown part from tthe part bag")
			continue
		
		_recursive_part_attach(ship, component, Vector2i(0, 0), {Vector2i(0, 0): true})
	return ship

#Basically a DFS with randomized child access
#Returns true if it could attach, otherwise false
func _recursive_part_attach(ship: Ship, part: Component, attach_coords: Vector2i, visited: Dictionary) -> bool:
	if not ship.has_component_at(attach_coords):
		#We first need to add the part somewhere as a child, because attach only reparents
		ship.add_child(part)
		ship.attach_component(part, attach_coords)
		return true
	
	var dirs = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
	dirs.shuffle()
	
	for dir in dirs:
		var new_attach = attach_coords + dir
		if !visited.has(new_attach):
			#Why oh why doesn't godot have a hash set
			visited[new_attach] = true
			if _recursive_part_attach(ship, part, new_attach, visited):
				return true
	
	return false

func _create_weapon() -> Component:
	var weapon: WeaponComponent = preload("res://Scenes/Components/weapon_component.tscn").instantiate()
	weapon.turret_stats = preload("res://Resources/Components/Weapons/Bolt1Turret.tres")
	weapon.component_stats = preload("res://Resources/Components/Weapons/Bolt1Component.tres")
	return weapon

func _create_armor() -> Component:
	var armor: Component = preload("res://Scenes/Components/component.tscn").instantiate()
	armor.component_stats = preload("res://Resources/Components/Armors/Armor1.tres")
	return armor
