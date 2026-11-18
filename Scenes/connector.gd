class_name Connector
extends Marker2D

signal connected(position_change, rotation_change)
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


func _on_connector_area_area_entered(area: Area2D) -> void:
	#Cannot connect to the connector, we don't care about it
	if !can_connect():
		return

	var area_parent = area.get_parent()
	if area_parent is not Connector:
		return
	
	var connector: Connector = area_parent
	
	#Connect it to the component
	pass # Replace with function body.
