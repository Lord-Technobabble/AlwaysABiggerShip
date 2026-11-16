extends GenericComponentStats

@export var power_generation: int = 0
@export var base_thrust: int = 1000
var thrust_info

func _init() -> void:
	thrust_info = ThrustInfo.new(base_thrust)
