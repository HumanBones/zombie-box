extends Control

class_name MainMenu

@onready var start: Button = $MainContainer/CentralContainer/VBoxContainer/Start
@onready var exit: Button = $MainContainer/CentralContainer/VBoxContainer/Exit
@onready var texture_rect: TextureRect = $TextureRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() ->void:
	animation_player.play("fade_out")

func hide_background() ->void:
	animation_player.play("fade_in")


func _on_start_pressed() ->void:
	SceneManager.change_to_game_scene()


func _on_exit_pressed() ->void:
	SceneManager.quit_game()
