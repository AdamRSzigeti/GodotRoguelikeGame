extends Node

signal exit_reached
signal exit_reached_gui

var level = 1
var highscore = 0

func _ready() -> void:
	GlobalVars.exit_reached.connect(change_level)

func change_level():
	level += 1
	exit_reached_gui.emit()
	get_tree().reload_current_scene()
	
func highscore_calc():
	highscore += level * 50
	highscore += Player.enemiesKilled * 25
	highscore += Player.wallsBroken * 15
	highscore += Player.eatenFood * 10
	
	#Level 50
	#Enemy 25
	#Wall 15
	#Food 10
