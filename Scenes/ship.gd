extends Node2D

var speed = Vector2(0, 0)
var weight: int = 1
var thrust_info: ThrustInfo = ThrustInfo.new(10)
@export var controller: GenericShipController = GenericShipController.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	calc_acc(delta)
	
	position += speed * delta

func calc_acc(delta: float) -> void:
	var use_thrusthers = controller.get_next_thrust()
	use_thrusthers.mul(thrust_info)
	
	var thrust = use_thrusthers.get_total_thrust().rotated(rotation)
	var acc = thrust / weight
	
	speed += acc * delta
