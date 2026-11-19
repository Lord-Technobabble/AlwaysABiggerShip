class_name Connector
extends Area2D

signal connection_requested(to, from)

#TODO handle disabling the hitbox when inactive/unconnected
@export var is_active: bool = true

var is_occupied: bool:
	get:
		return connected_to != null

var connected_to: Node2D = null

#Used to determine which connector will want to move to which
var will_parent: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func can_connect() -> bool:
	return is_active and !is_connected

func _on_area_entered(area: Area2D) -> void:
		#Cannot connect to the connector, we don't care about it
	if not can_connect():
		return

	if area is not Connector:
		return
	
	var connector: Connector = area
	
	connection_requested.emit(self, connector)
