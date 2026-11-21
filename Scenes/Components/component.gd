class_name Component
extends Area2D

signal connection_requested(static_connector: Connector,
							non_static_connector: Connector)

@export var component_stats: ComponentStats

var owner_ship: Ship = null
var ship_coord = Vector2i(0, 0)
var connectors: Array[Connector] = []

# Called when the node enters the scene tree for the first time.
func use_component_stats():
	if component_stats == null:
		push_error("There are no stats to use, please attach them")
		return
	$ComponentSprite.texture = component_stats.sprite

func _ready() -> void:
	for connector in $Connectors.get_children():
		connectors.append(connector)
	
	for connector in connectors:
		connector.connection_requested.connect(connector_connection_requested) #Try to say that twice :)
	
	use_component_stats()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func change_connector_static(is_static: bool):
	for connector in connectors:
		connector.is_static = is_static

func attach_to_ship(ship: Ship):
	if owner_ship != null:
		push_error("Component is already attached to ship")
		return
	owner_ship = ship
	
	change_connector_static(true)
	
	if component_stats == null:
		push_error("Trying to attach a component without stats")
		
	else:
		component_stats.attach_to_ship(owner_ship)

func detach_from_ship():
	if owner_ship == null:
		push_warning("Component is not attached to ship, so cannot remove")
		return
	
	change_connector_static(false)
	
	if component_stats == null:
		push_error("Trying to attach a component without stats")
	
	else:
		component_stats.detach_from_ship(owner_ship)
	owner_ship = null

func connector_connection_requested(sc: Connector, nsc: Connector):
	connection_requested.emit(sc, nsc)
