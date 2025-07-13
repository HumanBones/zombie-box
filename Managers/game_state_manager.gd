extends Node

signal game_over

var cur_game_state

func set_game_over() ->void:
	game_over.emit()
