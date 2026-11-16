class_name ComponentStats
extends Resource

@export var max_health: int
@export var weight: int

func attach_to_ship(ship: Ship):
	ship.weight += weight

func detach_from_ship(ship: Ship):
	ship.weight -= weight
