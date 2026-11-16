extends ComponentStats

@export var power_generation: int = 0
@export var base_thrust: int = 0
var thrust_info

func _init() -> void:
	thrust_info = ThrustInfo.new(base_thrust)

func attach_to_ship(ship: Ship):
	ship.power_generation += power_generation
	ship.thrust_info.add(thrust_info)
	super.attach_to_ship(ship)

func detach_from_ship(ship: Ship):
	ship.thrust_info.sub(thrust_info)
	ship.power_generation -= power_generation
	super.detach_from_ship(ship)
