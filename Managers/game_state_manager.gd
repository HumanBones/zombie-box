extends Node

signal game_over
signal game_paused
signal game_resumed

enum GameState {
	PAUSED,
	PLAYING,
	GAMEOVER
}

var player : Player

var cur_game_state : GameState

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	cur_game_state = GameState.PLAYING

func set_game_over() ->void:
	game_over.emit()
	cur_game_state = GameState.GAMEOVER

func pause_game() ->void:
	game_paused.emit()
	cur_game_state = GameState.PAUSED
	
func resume_game() ->void:
	game_resumed.emit()
	cur_game_state = GameState.PLAYING
