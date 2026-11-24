extends Node

signal shot(position: Vector2, rotation: float, shot_stats: ShotStats, target: Node2D)

func shoot(positon: Vector2, rotation: float, shot_stats: ShotStats, target: Node2D = null):
	shot.emit(positon, rotation, shot_stats, target)
