extends Node2D

const food = preload("res://Prefabs/Food.tscn")
const soda = preload("res://Prefabs/Soda.tscn")
const wall = preload("res://Prefabs/wall.tscn")
const enemy = preload("res://Prefabs/Units/enemy.tscn")


var cells = []

var level_count = GlobalVars.level

var food_max = 7
var wall_max = 11

var food_count = 0
var wall_count = 0
var enemy_count = logWithBase(level_count, 2)


func _ready() -> void:
	for i in self.get_children():
		cells.append(i.position)
	
	for i in cells:
		var pos = cells.pick_random()
		
		# 1 = food, 2 = soda, 3 = wall, 4 = nothing
		var to_place = randi_range(1, 4)
		if to_place == 1:
			if food_count < food_max:
				var food_inst = food.instantiate()
				self.add_child(food_inst)
				food_inst.position.x = pos.x + 16
				food_inst.position.y = pos.y + 16
				food_count += 1
				cells.erase(pos)
			else:
				pass
		elif to_place == 2:
			if food_count < food_max:
				var soda_inst = soda.instantiate()
				self.add_child(soda_inst)
				soda_inst.position.x = pos.x + 16
				soda_inst.position.y = pos.y + 16
				food_count += 1
				cells.erase(pos)
			else:
				pass
		elif to_place == 3:
			if wall_count < wall_max:
				var wall_inst = wall.instantiate()
				self.add_child(wall_inst)
				wall_inst.position.x = pos.x + 16
				wall_inst.position.y = pos.y + 16
				wall_count += 1
				cells.erase(pos)
			else:
				pass
		elif to_place == 4:
			pass
			cells.erase(pos)
		
	for i in enemy_count:
		var pos = cells.pick_random()
		var enemy_inst = enemy.instantiate()
		self.add_child(enemy_inst)
		enemy_inst.position.x = pos.x + 16
		enemy_inst.position.y = pos.y + 16
		
			
func logWithBase(value, base): 
	return log(value) / log(base)
