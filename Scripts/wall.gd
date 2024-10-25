extends StaticBody2D

@onready var sprite = $AnimatedSprite2D
var texture = str(randi_range(1, 7))

var wall_health = 2

var can_break = false


func _ready() -> void:
	sprite.play(texture)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_break = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_break = false
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact"):
		if can_break:
			Player.chop_anim()
			Player.lose_food(1)
			if wall_health > 0:
				sprite.play(texture + "_alt")
				wall_health -= 1
			elif wall_health <= 0:
				self.queue_free()
				Player.wallsBroken += 1
