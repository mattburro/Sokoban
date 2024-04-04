extends CanvasLayer

const BUTTON_SCENE: PackedScene = preload("res://level_button/level_button.tscn")
const LEVEL_COLUMNS: int = 6
const LEVEL_ROWS: int = 5

@onready var grid_container = $MarginContainer/VBoxContainer/GridContainer

func _ready():
	ScoreManager.load_scores()
	setup_level_buttons()

func setup_level_buttons():
	for level_number in range(LEVEL_COLUMNS * LEVEL_ROWS):
		var button = BUTTON_SCENE.instantiate()
		button.set_level_number(str(level_number + 1))
		grid_container.add_child(button)
