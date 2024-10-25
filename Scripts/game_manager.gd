extends Node2D

@onready var tilemap = $TileMapLayer

const MAP_SIZE = Vector2(9, 9)
const LAND_CAP = 1

func _ready():
	generate_map()
	print(GlobalVars.level)
	
func generate_map():
	var noise = FastNoiseLite.new()
	noise.seed = randi()
	var cells = []
	for x in MAP_SIZE.x:
		for y in MAP_SIZE.y:
			var value = noise.get_noise_2d(x, y)
			if value < LAND_CAP:
				cells.append(Vector2(x, y))
	tilemap.set_cells_terrain_connect(cells, 0, 0, 0)
	
