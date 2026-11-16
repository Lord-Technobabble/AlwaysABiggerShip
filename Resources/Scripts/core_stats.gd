extends ComponentStats

@export var power_generation: int = 0
@export var base_thrust: int = 0
@export var rotation_power: int = 0


func attach_to_ship(ship: Ship):
	ship.power_generation += power_generation
	ship.thrust_info.add(ThrustInfo.new(base_thrust))
	ship.rotation_power += rotation_power
	super.attach_to_ship(ship)

func detach_from_ship(ship: Ship):
	ship.thrust_info.sub(ThrustInfo.new(base_thrust))
	ship.power_generation -= power_generation
	ship.rotation_power -= rotation_power
	super.detach_from_ship(ship)
