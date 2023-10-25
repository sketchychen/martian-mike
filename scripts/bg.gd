extends ParallaxBackground


@export var bg_texture: CompressedTexture2D = preload("res://assets/textures/bg/bg.png")
@export var scroll_vector = Vector2(15, 15)

@onready var sprite = $ParallaxLayer/Sprite2D


func _ready():
	sprite.texture = bg_texture


func _process(delta):
	sprite.region_rect.position += delta * scroll_vector
	
	if sprite.region_rect.position >= Vector2(256, 256):
		sprite.region_rect.position = Vector2.ZERO
