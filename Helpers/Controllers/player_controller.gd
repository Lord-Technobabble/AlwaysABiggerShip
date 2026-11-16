class_name PlayerController
extends DampenerController

@export var dampen_thrust: bool = true
@export var dampen_rot: bool = true

func get_next_thrust() -> ThrustInfo:
	var thrust_info = ThrustInfo.new(0)
	
	if Input.is_action_pressed("go_aft"):
		thrust_info.to_aft = 1

	if Input.is_action_pressed("go_fore"):
		thrust_info.to_fore = 1
	
	if Input.is_action_pressed("go_port"):
		thrust_info.to_port = 1
	
	if Input.is_action_pressed("go_starboard"):
		thrust_info.to_starboard = 1
	
	if dampen_thrust and thrust_info.get_total_thrust().length() == 0:
		return super.get_next_thrust()
	return thrust_info

func get_next_rotation() -> float:
	var result = 0
	
	if Input.is_action_pressed("rotate_to_port"):
		result += 1
	
	if Input.is_action_pressed("rotate_to_starboard"):
		result -= 1
	
	if dampen_rot and result == 0:
		return super.get_next_rotation()
	return result
