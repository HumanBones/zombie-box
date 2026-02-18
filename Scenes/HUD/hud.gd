extends Control

class_name HUD

signal score_label_updated

@onready var game_over_label: Label = $MainContainer/CenterContainer/GameOver
@onready var wave_label: Label = $MainContainer/CenterContainer/WaveLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var blood_effect: TextureRect = $BloodEffect
@onready var game_over_timer: Timer = $GameOverTimer
@onready var timer: Timer = $Timer
@onready var kills_label: Label = $MainContainer/KillsLabel


func _ready() -> void:
	SpawnManager.cur_wave.connect(update_wave_label)
	SpawnManager.finished_waves.connect(waves_finished)
	GameStateManager.game_over.connect(is_game_over)
	ScoreManager.score_updated.connect(update_score)
	ScoreManager.new_high_score.connect(new_high_score)
	game_over_label.hide()

func update_wave_label(amount: int) ->void:
	wave_label.show()
	wave_label.text = "Wave " + str(amount+1)
	animation_player.play("fade_label")

func _process(delta: float) ->void:
	if Input.is_action_just_pressed("pause"):
		if GameStateManager.cur_game_state == GameStateManager.GameState.PLAYING:
			GameStateManager.pause_game()
		else:
			GameStateManager.resume_game()

func _on_timer_timeout() ->void:
	wave_label.show()
	update_wave_label(0)

func hide_label() ->void:
	wave_label.hide()

func waves_finished() ->void:
	wave_label.show()
	wave_label.text = "Wave finished!"
	animation_player.play("fade_label")

func is_game_over() ->void:
	game_over_label.show()
	blood_effect.hide()
	animation_player.play("blink_label")
	game_over_timer.start()

func _on_player_player_hit() ->void:
	blood_effect.show()
	animation_player.play("blood_fade")

func _on_game_over_timer_timeout() ->void:
	SceneManager.change_to_main_menu()
	ScoreManager.reset_score()

func game_paused() ->void:
	game_over_timer.paused = true
	timer.paused = true
	
func game_resumed() ->void:
	game_over_timer.paused = false
	timer.paused = false

func update_score(amount: int) ->void:
	animation_player.play("pop")
	kills_label.text = "%03d" % amount
	score_label_updated.emit()
	
func new_high_score(amount: int) ->void:
	#do some effect
	pass
