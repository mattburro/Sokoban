extends Node

const SCORE_FILE: String = "user://scores.bat"
const MAX_SCORE: int = 10000

var _best_scores: Dictionary = {}

func _ready():
	load_scores()

func load_scores():
	if not FileAccess.file_exists(SCORE_FILE):
		return
	
	var file = FileAccess.open(SCORE_FILE, FileAccess.READ)
	_best_scores = JSON.parse_string(file.get_as_text())

func save_scores():
	var file = FileAccess.open(SCORE_FILE, FileAccess.WRITE)
	file.store_string(JSON.stringify(_best_scores))

func level_has_score(level: String):
	return level in _best_scores

func get_level_score(level: String) -> int:
	if level_has_score(level):
		return _best_scores[level]
	else:
		return MAX_SCORE

func is_level_best_score(level: String, moves: int) -> bool:
	if not level_has_score(level) or get_level_score(level) > moves:
		return true
	else:
		return false

func level_completed(level: String, moves: int):
	if is_level_best_score(level, moves):
		_best_scores[level] = moves
	
	save_scores()
