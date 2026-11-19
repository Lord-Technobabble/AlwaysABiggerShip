class_name connector_group
extends Object

var connectors: Array[Connector] = []

func _init(cons: Array[Connector]) -> void:
	connectors = cons

func connect_connection_signal(callable: Callable):
	for connector in connectors:
		connector.connection_requested.connect(callable)
