extends Control

@onready var hud = $Hud
@onready var food_display = $Hud/Food
@onready var level_change = $LevelChange
@onready var game_over = $GameOver
@onready var game_over_days = $GameOver/DaysSurvived   
@onready var level_change_days = $LevelChange/Days
@onready var highscore = $Highscore
@onready var walls_broken = $Highscore/WallsBroken
@onready var food_eaten = $Highscore/FoodEaten
@onready var enemies_killed = $Highscore/EnemiesKilled
@onready var highscore_label = $Highscore/HighscoreLabel
@onready var days_survived = $Highscore/DaysSurvivedLabel

signal Hide_Controls
signal Show_Controls

func _ready() -> void:
	GlobalVars.exit_reached_gui.connect(levelchangescreen)
	Player.add_food.connect(add_food_display)
	Player.lost_food.connect(lose_food_display)
	
func levelchangescreen():
	Hide_Controls.emit()
	level_change.visible = true
	level_change_days.text = "Day: " + str(GlobalVars.level)  
	get_tree().paused = true
	await get_tree().create_timer(2.0).timeout 
	level_change.visible = false
	get_tree().paused = false
	Show_Controls.emit()
	
func gameover():
	Hide_Controls.emit()
	GlobalVars.highscore_calc()
	game_over.visible = true
	game_over_days.text = "You survived " + str(GlobalVars.level) + " days!"
	get_tree().paused = true
	await get_tree().create_timer(1.0).timeout
	get_tree().paused = false
	game_over.visible = false
	walls_broken.text = "Walls Broken: " + str(Player.wallsBroken)
	food_eaten.text = "Food Eaten: " + str(Player.eatenFood)
	enemies_killed.text = "Enemies Killed: " + str(Player.enemiesKilled)
	days_survived.text = "Days Survived: " + str(GlobalVars.level)
	highscore_label.text = "HIGHSCORE: " + str(GlobalVars.highscore)
	highscore.visible = true
	get_tree().paused = true
	
	
	
	
func add_food_display(amount):
	food_display.text = "Food: " + str(Player.food) + " + " + str(amount)
	await get_tree().create_timer(0.5).timeout
	food_display.text = "Food: " + str(Player.food)
	
func lose_food_display(amount):
	food_display.text = "Food: " + str(Player.food) + " - " + str(amount)
	await get_tree().create_timer(0.5).timeout
	food_display.text = "Food: " + str(Player.food)
