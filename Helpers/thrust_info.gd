class_name ThrustInfo
extends Resource

#Gives info about thrust in that direction, so aft thrusters increase "to_fore"
var to_port: float = 0
var to_starboard: float = 0
var to_fore: float = 0
var to_aft: float = 0

func _init(base_val: float = 0) -> void:
	to_port = base_val
	to_starboard = base_val
	to_fore = base_val
	to_aft = base_val
	
func add(b: ThrustInfo):
	to_port += b.to_port
	to_starboard += b.to_starboard
	to_fore += b.to_fore
	to_aft += b.to_aft

func mul(b):
	if b is ThrustInfo:
		_TI_mul(b)
		return
	
	if b is float:
		_num_mul(b)

func _TI_mul(b: ThrustInfo):
	to_port *= b.to_port
	to_starboard *= b.to_starboard
	to_fore *= b.to_fore
	to_aft *= b.to_aft

func _num_mul(b: float):
	to_port *= b
	to_starboard *= b
	to_fore *= b
	to_aft *=  b

func get_total_thrust() -> Vector2:
	var x = to_starboard - to_port
	var y = to_aft - to_fore
	
	return Vector2(x, y)
