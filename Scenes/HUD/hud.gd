extends Control

class_name HUD

@onready var game_over_label: Label = $MainContainer/CenterContainer/GameOver
@onready var label: Label = $MainContainer/CenterContainer/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var blood_effect: TextureRect = $BloodEffect
@onready var game_over_timer: Timer = $GameOverTimer
@onready var timer: Timer = $Timer


func _ready() -> void:
	SpawnManager.cur_wave.connect(update_wave_label)
	SpawnManager.finished_waves.connect(waves_finished)
	GameStateManager.game_over.connect(is_game_over)
	game_over_label.hide()

func update_wave_label(amount:int) ->void:
	label.show()
	label.text = "Wave " + str(amount+1)
	animation_player.play("fade_label")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if GameStateManager.cur_game_state == GameStateManager.GameState.PLAYING:
			GameStateManager.pause_game()
		else:
			GameStateManager.resume_game()

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
	blood_effect.hide()
	animation_player.play("blink_label")
	game_over_timer.start()

func _on_player_player_hit() -> void:
	blood_effect.show()
	animation_player.play("blood_fade")

func _on_game_over_timer_timeout() -> void:
	SceneManager.change_to_main_menu()

func game_paused() ->void:
	game_over_timer.paused = true
	timer.paused = true
	
func game_resumed() ->void:
	game_over_timer.paused = false
	timer.paused = false
