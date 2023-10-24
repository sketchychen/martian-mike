extends CharacterBody2D
class_name Player

@export var gravity = 400
@export var terminal_velocity = 500
@export var speed = 125
@export var jump_force = 200

@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y += gravity * delta
		if velocity.y > terminal_velocity:
			velocity.y = terminal_velocity
	
	if Input.is_action_just_pressed("jump"): #&& is_on_floor() == true:
		jump(jump_force)
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		animated_sprite.flip_h = direction == -1
	
	velocity.x = direction * speed
	
	move_and_slide()
	
	update_animations(direction)


func jump(force):
	velocity.y = -force


func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")