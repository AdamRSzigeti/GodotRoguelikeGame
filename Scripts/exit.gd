extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Player.position = Vector2(162 + 16, 32 + 16)
		await get_tree().create_timer(0.1).timeout
		GlobalVars.exit_reached.emit()

func _input(event):
	if Input.is_action_just_pressed("ui_select"):
		Player.position = Vector2(162 + 16, 32 + 16)
		GlobalVars.exit_reached.emit()
	if Input.is_action_just_pressed("ui_focus_next"):
		Gui.gameover()
