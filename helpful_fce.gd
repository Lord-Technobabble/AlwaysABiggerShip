extends Node

func bounded_randi(low, high) -> int:
	return (randi() % (high - low)) + low
