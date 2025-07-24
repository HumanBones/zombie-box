extends Node

signal scene_changed
signal game_quit

var cur_scene : PackedScene

const GAME_SCENE = preload("res://Scenes/World/world.tscn")
const MAIN_MENU = preload("res://Scenes/MainMenu/main_menu.tscn")

func change_to_game_scene() ->void:
	get_tree().change_scene_to_packed(GAME_SCENE)
	cur_scene = GAME_SCENE
	scene_changed.emit(cur_scene)

func change_to_main_menu() ->void:
	get_tree().change_scene_to_packed(MAIN_MENU)
	cur_scene = MAIN_MENU
	scene_changed.emit(cur_scene)

func quit_game() ->void:
	game_quit.emit()
	get_tree().quit()
