extends Node

const ARMOR_LOW_BOUND = 5
const ARMOR_HIGH_BOUND = 10
const WEAPON_LOW_BOUND = 2
const WEAPON_HIGH_BOUND = 11

func create_basic_ship() -> Ship:
	#We get a bag randomizer and put in the parts we want to create the ship from
	var bag = BagRandomizer.new()
	bag.put("armor", HelpfulFce.bounded_randi(ARMOR_LOW_BOUND, ARMOR_HIGH_BOUND))
	bag.put("weapon", HelpfulFce.bounded_randi(WEAPON_LOW_BOUND, WEAPON_HIGH_BOUND))
	return create_ship_from_bag(bag)

func create_ship_from_bag(part_bag: BagRandomizer) -> Ship:
	var ship: Ship = preload("res://Scenes/ship.tscn").instantiate()
	ship.attach_core(preload("res://Scenes/Components/default_core.tscn").instantiate())
	
	while not part_bag.is_empty():
		pass
	return ship
