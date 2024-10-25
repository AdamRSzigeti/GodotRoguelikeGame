extends StaticBody2D

@onready var sprite = $AnimatedSprite2D


func _ready() -> void:
	var texture = str(randi_range(1, 3))

	sprite.play(texture)
	
