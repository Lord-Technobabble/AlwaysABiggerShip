class_name Ship
extends Node2D

var speed = Vector2(0, 0)
var rotation_speed = 0
var weight: int = 0
var thrust_info: ThrustInfo = ThrustInfo.new(0)
var power_generation = 0
var power_drain = 0

@export var controller: GenericShipController = GenericShipController.new()
@export var starting_core_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var core = starting_core_scene.instantiate()
	add_child(core)
	attach_component(core)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	calc_acc(delta)
	
	position += speed * delta

func calc_acc(delta: float) -> void:
	if weight == 0:
		return

	var use_thrusthers = controller.get_next_thrust()
	use_thrusthers.mul(thrust_info)
	
	var thrust = use_thrusthers.get_total_thrust().rotated(rotation)
	var acc = thrust / weight
	
	speed += acc * delta

# Updates all ship values to be in line with the attached component
func attach_component(component):
	if component is Component:
		component.component_stats.attach_to_ship(self)
	return
