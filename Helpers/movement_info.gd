class_name MovementInfo
extends Resource

var velocity: Vector2
var rotation_speed: float
var rotation: float

func _init(vel = Vector2(0, 0), rot = 0, rot_spd = 0) -> void:
	velocity = vel
	rotation = rot
	rotation_speed = rot_spd
