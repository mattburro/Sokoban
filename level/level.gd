extends Node2D

const FLOOR_LAYER = 0
const WALL_LAYER = 1
const TARGET_LAYER = 2
const BOX_LAYER = 3

const SOURCE_ID = 0

const LAYER_KEY_FLOOR = "Floor"
const LAYER_KEY_WALLS = "Walls"
const LAYER_KEY_TARGETS = "Targets"
const LAYER_KEY_TARGET_BOXES = "TargetBoxes"
const LAYER_KEY_BOXES = "Boxes"

const LAYER_MAP = {
	LAYER_KEY_FLOOR: FLOOR_LAYER,
	LAYER_KEY_WALLS: WALL_LAYER,
	LAYER_KEY_TARGETS: TARGET_LAYER,
	LAYER_KEY_TARGET_BOXES: BOX_LAYER,
	LAYER_KEY_BOXES: BOX_LAYER
}

@onready var camera = $Camera2D
@onready var tile_map = $TileMap
@onready var player = $Player

func _ready():
	_setup_level()

func _setup_level():
	tile_map.clear()
	var level_data = GameData.get_data_for_level("1")
	var level_tiles = level_data.tiles
	var player_start = level_data.player_start
	
	for layer_name in LAYER_MAP.keys():
		_add_layer_tiles(level_tiles[layer_name], layer_name)
	
	_place_player_on_tile(Vector2i(player_start.x, player_start.y))
	_center_camera_on_tiles()

func _add_layer_tiles(layer_tiles: Array, layer_name: String):
	for tile_coord in layer_tiles:
		_add_tile(tile_coord.coord, layer_name)

func _add_tile(tile_coord: Dictionary, layer_name: String):
	var layer_number = LAYER_MAP[layer_name]
	var coords = Vector2i(tile_coord.x, tile_coord.y)
	var atlas_coords = _get_atlas_coord_for_layer_name(layer_name)
	
	tile_map.set_cell(layer_number, coords, SOURCE_ID, atlas_coords)

func _get_atlas_coord_for_layer_name(layer_name: String) -> Vector2i:
	match layer_name:
		LAYER_KEY_FLOOR:
			return Vector2i(randi_range(3, 8), 0)
		LAYER_KEY_WALLS:
			return Vector2i(2, 0)
		LAYER_KEY_TARGETS:
			return Vector2i(9, 0)
		LAYER_KEY_TARGET_BOXES:
			return Vector2i(0, 0)
		LAYER_KEY_BOXES:
			return Vector2i(1, 0)
		_:
			return Vector2i(0, 0)

func _place_player_on_tile(tile_pos: Vector2i):
	var spawn_pos = Vector2(
		tile_pos.x * GameData.TILE_SIZE,
		tile_pos.y * GameData.TILE_SIZE
	) + tile_map.global_position
	player.global_position = spawn_pos

func _center_camera_on_tiles():
	var tmr = tile_map.get_used_rect()
	var camera_pos = Vector2(
		((tmr.position.x + tmr.end.x) / 2) * GameData.TILE_SIZE,
		((tmr.position.y + tmr.end.y) / 2) * GameData.TILE_SIZE,
	)
	camera.global_position = camera_pos
