extends Node2D

var weight: int = 0
var thrust_info: ThrustInfo = ThrustInfo.new(100)
@export var controller: GenericShipController = GenericShipController.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#The following movement is only for DEBUG purposes, later on it will correctly do acceleration
	var use_thrusthers = controller.get_next_thrust()
	use_thrusthers.mul(thrust_info)
	
	var speed = use_thrusthers.get_total_thrust()
	#End of debug code
	
	position += speed * delta
