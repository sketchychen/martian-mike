extends StaticBody2D


@onready var spawn_point = $SpawnPoint


func get_spawn_pos():
	return spawn_point.global_position
