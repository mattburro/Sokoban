extends Node

const LEVEL_SCENE: PackedScene = preload("res://level/level.tscn")
const MAIN_SCENE: PackedScene = preload("res://main/main.tscn")

var _level_selected: String

func _ready():
	SignalManager.on_level_selected.connect(on_level_selected)

func on_level_selected(level_number: String):
	_level_selected = level_number
	get_tree().change_scene_to_packed(LEVEL_SCENE)

func load_main_scene():
	get_tree().change_scene_to_packed(MAIN_SCENE)

func get_level_selected() -> String:
	return _level_selected
