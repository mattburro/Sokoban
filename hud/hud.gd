extends Control

@onready var level_label = %LevelLabel
@onready var moves_label = %MovesLabel
@onready var best_label = %BestLabel

func set_level_label(level: String):
	level_label.text = level

func set_moves_label(moves: int):
	moves_label.text = str(moves)

func set_best_label(best: int):
	best_label.text = str(best)

func new_game(level: String):
	set_best_label(ScoreManager.get_level_score(level))
	set_moves_label(0)
	set_level_label(level)
	show()
