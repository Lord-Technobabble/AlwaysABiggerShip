class_name Connector
extends Area2D

#Signal emited when 
signal connection_requested(static_connector: Connector, non_static_connector: Connector)

#TODO handle disabling the hitbox when inactive/unconnected

#For disabling specific connectors
@export var is_active: bool = true

#Only a static and a non static connector can connect
@export var is_static: bool = false

@export var connection_coords: Vector2i = Vector2i(0, 0)
@export var parent: Node2D

var is_occupied: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func can_connect() -> bool:
	return is_active and is_static and !is_occupied

func _on_area_entered(area: Area2D) -> void:
		#Cannot connect to the connector, we don't care about it
	if not can_connect():
		return

	if area is not Connector:
		return
	
	var other_connector: Connector = area
	
	if other_connector.is_static:
		return
	
	if other_connector.parent == null:
		push_error("There is a connector to nothing just floating")

	connection_requested.emit(self, other_connector)
