extends Node

const LEVEL_DATA_PATH: String = "res://data/level_data.json"
const TILE_SIZE: int = 32

var _level_data: Dictionary = {}

func _ready():
	_load_level_data()

func get_data_for_level(level_num: String) -> Dictionary:
	return _level_data[level_num]

func _load_level_data():
	var file = FileAccess.open(LEVEL_DATA_PATH, FileAccess.READ)
	_level_data = JSON.parse_string(file.get_as_text())
