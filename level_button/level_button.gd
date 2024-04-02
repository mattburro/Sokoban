extends NinePatchRect

const GREEN_TEXTURE = preload("res://assets/green_panel.png")

var _level_number: String = "99"

@onready var level_label = $LevelLabel
@onready var checkmark = $Checkmark

func _ready():
	level_label.text = _level_number

func set_level_number(level_number):
	_level_number = level_number

func _on_gui_input(event: InputEvent):
	if event.is_action_pressed("select"):
		texture = GREEN_TEXTURE
