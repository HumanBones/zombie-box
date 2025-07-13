extends Control

class_name HUD

@onready var game_over_label: Label = $MainContainer/CenterContainer/GameOver
@onready var label: Label = $MainContainer/CenterContainer/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	SpawnManager.cur_wave.connect(update_wave_label)
	SpawnManager.finished_waves.connect(waves_finished)
	GameStateManager.game_over.connect(is_game_over)
	game_over_label.hide()

func update_wave_label(amount:int) ->void:
	label.show()
	label.text = "Wave " + str(amount+1)
	animation_player.play("fade_label")


func _on_timer_timeout() -> void:
	label.show()
	update_wave_label(0)

func hide_label() ->void:
	label.hide()

func waves_finished() ->void:
	label.show()
	label.text = "Wave finished!"
	animation_player.play("fade_label")

func is_game_over() ->void:
	game_over_label.show()
	animation_player.play("game_over_blink")
