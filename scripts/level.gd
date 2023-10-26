extends Node2D

@export var next_level: PackedScene
@export var is_final_level: bool = false
@export var level_time = 5

@onready var deathzone = $Deathzone
@onready var start = $Start
@onready var exit = $Exit
@onready var ui = $UI
@onready var hud = $UI/HUD

var player = null
var timer_node = null
var time_left

func _ready():
	player = get_tree().get_first_node_in_group("player")
	if player != null:
		player.global_position = start.get_spawn_pos()
	
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)
		
	exit.body_entered.connect(_on_exit_body_entered)
	deathzone.body_entered.connect(_on_deathzone_body_entered)
	
	time_left = level_time
	hud.set_time_label(time_left)
	timer_node = Timer.new()
	timer_node.name = "Level Timer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node)
	timer_node.start()


func _process(delta):
#	if Input.is_action_just_pressed("quit"):
#		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_deathzone_body_entered(body):
	AudioPlayer.play_sfx("hurt")
	reset_player()


func _on_trap_touched_player():
	AudioPlayer.play_sfx("hurt")
	reset_player()


func _on_exit_body_entered(body):
	if body is Player:
		timer_node.stop()
		exit.animate()
		player.active = false
		await get_tree().create_timer(1.5).timeout
		if is_final_level || (next_level != null):
			if is_final_level:
				ui.show_win_screen(true)
			else:
				get_tree().change_scene_to_packed(next_level)


func _on_level_timer_timeout():
	time_left -= 1
	hud.set_time_label(time_left)
	if time_left <= 0:
		reset_player()
		time_left = level_time


func reset_player():
	player.velocity = Vector2.ZERO
	player.global_position = start.get_spawn_pos()

