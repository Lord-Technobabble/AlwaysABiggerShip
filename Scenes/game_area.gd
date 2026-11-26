extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player_ship = ShipCreator.create_basic_ship()
	player_ship.controller = preload("res://Helpers/PlayerController.tres")
	add_child(player_ship)
	player_ship.position = $InitialPlayerSpawn.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
