class_name DampenerController
extends DeadShipController

#TODO fix there being slight movement when dampening due to the imperfections of navigation

func get_next_rotation() -> float:
	if last_move == null:
		return 0
	
	if last_move.rotation_speed == 0:
		return 0

	return -last_move.rotation_speed / abs(last_move.rotation_speed)

func get_next_thrust() -> ThrustInfo:
	var result = ThrustInfo.new(0)
	if last_move == null:
		return result
	
	if last_move.velocity.length() == 0:
		return result
	
	var ship_centric_vel = last_move.velocity.rotated(-last_move.rotation)
	
	if ship_centric_vel.y > 0:
		result.to_fore = 1
	elif ship_centric_vel.y < 0:
		result.to_aft = 1
	
	if ship_centric_vel.x < 0:
		result.to_starboard = 1
	elif ship_centric_vel.x > 0:
		result.to_port = 1

	return result
