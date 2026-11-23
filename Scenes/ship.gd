class_name Ship
extends Node2D

@export var controller: DeadShipController = DeadShipController.new()
@export var starting_core_scene: PackedScene

var speed = Vector2(0, 0)
var rotation_speed = 0

#Movement Cutoffs
const ROT_CUTOFF = 0.1
const SPEED_CUTOFF = 1

#Bimap for easy two way component lookup
#Cause Godot doesn't let me set my own variant type its {Vector2I : Component}
var components_map = BiMap.new()

#Component stats
var weight: int = 0
var thrust_info: ThrustInfo = ThrustInfo.new(0)
var power_generation = 0
var power_drain = 0
var rotation_power = 0
var has_core = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var core = starting_core_scene.instantiate()
	attach_core(core)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move(delta)

func move(delta: float) -> void:
	if weight == 0:
		push_error("Ship weight 0, infinite speed would be achieved")
		return
	
	calc_rot(delta)
	calc_acc(delta)
	controller.update_movement_info(MovementInfo.new(speed, rotation, rotation_speed))

func calc_rot(delta: float) -> void:
	var next_rot = controller.get_next_rotation()
	var rotation_acc = next_rot * rotation_power / weight
	
	rotation_speed += rotation_acc * delta
	if abs(rotation_speed) < ROT_CUTOFF:
		rotation_speed = 0

	rotation += rotation_speed * delta
	
func calc_acc(delta: float) -> void:
	var use_thrusthers = controller.get_next_thrust()
	use_thrusthers.mul(thrust_info)
	
	var thrust = use_thrusthers.get_total_thrust().rotated(rotation)
	var acc = thrust / weight
	
	speed += acc * delta
	if abs(speed.x) < SPEED_CUTOFF:
		speed.x = 0
	if abs(speed.y) < SPEED_CUTOFF:
		speed.y = 0

	position += speed * delta

func attach_core(core: Component):
	add_child(core)
	attach_component(core, Vector2i(0, 0))

# Updates all ship values to be in line with the attached component
func attach_component(component: Component, coords: Vector2i, new_rotation: float = 0):
	component.attach_to_ship(self)
	component.reparent(self, true)
	
	var new_pos = coords * Constants.COMPONENT_GRID_SIZE
	component.position = new_pos
	

	component.rotation = new_rotation
	
	if components_map.has_a(coords):
		push_error("Trying to attach a component to a location, that already has one")
	components_map.assign(coords, component)
	
	update_connectors_around(coords)
	component.connection_requested.connect(component_connection_requested)

func update_connectors_around(coords: Vector2i):
	#We look if there's something on the coords and update the surrounding components connectors accordingly
	var coords_comp: Component = components_map.get_b(coords)
	var directions: Array[Vector2i] = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
	
	for dir in directions:
		if !components_map.has_a(coords + dir):
			continue
		
		var comp: Component = components_map.get_b(coords + dir)
		comp.connectors[-dir].is_occupied = coords_comp != null
		
		if coords_comp != null:
			if coords_comp.connectors.has(dir):
				continue
			coords_comp.connectors[dir].is_occupied = true

func component_connection_requested(sc: Connector, nsc: Connector):
	var placement_coords = components_map.get_a(sc.parent) + sc.connection_coords
	
	#TODO handle snapping to the corresponding connector rotation
	var new_rotation = 0
	
	attach_component(nsc.parent, placement_coords, new_rotation)

func get_closest_component(to: Vector2) -> Component:
	#TODO make this correct, for testing, targets the center of the ship
	push_warning("DEBUG: This is not fully implemented, complete it before finishing the product")
	return components_map.get_b(Vector2i(0, 0))
