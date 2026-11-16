class_name Ship
extends Node2D
@export var controller: DeadShipController = DeadShipController.new()
@export var starting_core_scene: PackedScene

var speed = Vector2(0, 0)
var rotation_speed = 0

#Movement Cutoffs
const ROT_CUTOFF = 0.1
const SPEED_CUTOFF = 1

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

func attach_core(core):
	if core is Component:
		attach_component(core)
		add_child(core)
		core.dist_to_core = 0

# Updates all ship values to be in line with the attached component
func attach_component(component):
	if component is Component:
		component.attach_to_ship(self)
	return
