class_name ComponentStats
extends Resource

@export var max_health: int = 100
@export var weight: int = 1

func attach_to_ship(ship: Ship):
	ship.weight += weight

func detach_from_ship(ship: Ship):
	ship.weight -= weight
