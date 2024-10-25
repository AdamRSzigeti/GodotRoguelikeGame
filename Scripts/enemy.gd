extends CharacterBody2D

const speed = 64

@onready var player = get_node("/root/Player")
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var animator = $AnimatedSprite2D

var damage = 10
var enemy_type = str(randi_range(1, 2))
var attacking: bool
var can_move: bool
var health = 2

func _ready():
	animator.play("Idle_" + enemy_type)
	
func _physics_process(_delta: float) -> void:
	if can_move:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * speed
		move_and_slide()
	
	
func makepath() -> void:
	nav_agent.target_position = player.global_position
	

func _on_timer_timeout() -> void:
	makepath()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		attacking = true



func _on_timer_2_timeout() -> void:
	if attacking:
		player.lose_food(damage)
		animator.play("Attack_" + enemy_type)
	else:
		animator.play("Idle_" + enemy_type)


func _on_animated_sprite_2d_animation_finished() -> void:
	animator.play("Idle_" + enemy_type)


func _on_movement_timer_timeout() -> void:
	if can_move:
		can_move = false
	elif not can_move:
		can_move = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		attacking = false
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact") and attacking:
		Player.chop_anim()
		Player.lose_food(2)
		if health > 0:
			health -= 1
		elif health <= 0:
			self.queue_free()
			Player.enemiesKilled += 1
		
		
