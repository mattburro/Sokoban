extends Control

@onready var moves_label = %MovesLabel
@onready var record_label = $MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/RecordLabel

func new_game():
	hide()
	record_label.hide()

func game_over(level: String, moves: int):
	moves_label.text = str(moves)
	
	if ScoreManager.is_level_best_score(level, moves):
		record_label.show()
	
	show()
