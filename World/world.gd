extends Node2D

@onready var tile_map = $TileMap
@export var noise_height_text : NoiseTexture2D
var noise : Noise

var source_id =0
var water_atlas = Vector2i(0, 1)
var land_atlas = Vector2i(0,0)

var sand_titles_arr = []
var grass_titles_arr = []
var terrain_sand_int = 1
var terrain_grass_int = 2

var water_layer = 0
var groud_layer = 1
var cliff_layer = 3


var width = 400
var height = 400

func _ready() -> void:
	noise = noise_height_text.noise
	generate_world()
	
	
func generate_world():
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			var noise_val = noise.get_noise_2d(x, y)
			if noise_val > 0.0:
				sand_titles_arr.append(Vector2i(x,y))		
			tile_map.set_cell(water_layer,Vector2(x, y), source_id, water_atlas)
	tile_map.set_cells_terrain_connect(groud_layer, sand_titles_arr, terrain_sand_int, 0)
