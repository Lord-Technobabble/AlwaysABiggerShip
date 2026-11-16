class_name Component
extends Area2D

@export var component_stats: ComponentStats

var owner_ship: Ship = null
var dist_to_core: int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func attach_to_ship(ship: Ship):
	if owner_ship != null:
		push_error("Component is already attached to ship")
		return
	owner_ship = ship
	component_stats.attach_to_ship(owner_ship)

func detach_from_ship():
	if owner_ship == null:
		push_warning("Component is not attached to ship, so cannot remove")
		return
	component_stats.detach_from_ship(owner_ship)
	owner_ship = null
