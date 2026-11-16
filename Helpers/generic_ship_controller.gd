class_name GenericShipController
extends Resource

#This abstract class exists so we can plug n play different AI types/player control types
func get_next_thrust() -> ThrustInfo:
	return ThrustInfo.new(0)
