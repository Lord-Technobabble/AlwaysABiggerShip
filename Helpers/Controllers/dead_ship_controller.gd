class_name DeadShipController
extends Resource

var last_move: MovementInfo = null
#This abstract class exists so we can plug n play different AI types/player control types
func get_next_thrust() -> ThrustInfo:
	return ThrustInfo.new(0)

func get_next_rotation() -> float:
	return 0

func update_movement_info(info: MovementInfo):
	last_move = info
