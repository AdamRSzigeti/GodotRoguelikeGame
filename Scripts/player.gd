extends CharacterBody2D

var speed = 128
var food = 100
var moving: bool
var can_move: bool

var enemiesKilled = 0
var wallsBroken = 0
var eatenFood = 0

@onready var timer = $Timer
@onready var animation = $AnimatedSprite2D

signal add_food(amount: int)
signal lost_food(amount: int)

func _ready():
	animation.play("Idle")
	self.position = Vector2(162 + 16, 32 + 16)

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	
	if direction:
		moving = true
	else:
		moving = false
	
	move_and_slide()
	
	# type 1 is Food type 2 is Soda
func eat(type):
	if type == 1:
		food += 10
		add_food.emit(10)
		eatenFood += 1
	elif type == 2:
		food += 20
		add_food.emit(20)
		eatenFood += 1

func lose_food(amount):
	food -= amount
	is_game_over()
	lost_food.emit(amount)
	
func is_game_over():
	if food > 0:
		pass
	if food <= 0:
		game_over()

func game_over():
	Gui.gameover()

func chop_anim():
	animation.play("Chop")

func _on_animated_sprite_2d_animation_finished() -> void:
		animation.play("Idle")


func _on_timer_timeout() -> void:
	if moving:
		lose_food(5)


func _on_movement_timer_timeout() -> void:
	pass # Replace with function body.
