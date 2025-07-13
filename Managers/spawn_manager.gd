extends Node

signal next_wave
signal pick_upgrade
signal finished_waves
signal enemy_count_updated
signal cur_wave(amount)

var player : Player
var wave_count : int = 1
var enemies : Array[Zombie]
var cur_wave_count : int

func _ready() -> void:
	PowerUpManager.powerup_used.connect(upgrade_picked)
	player = get_tree().get_first_node_in_group("Player")

func free() -> void:
	cur_wave_count = 1

func add_enemy(enemy : Zombie) ->void:
	enemies.append(enemy)
	enemy_count_updated.emit()
	
func remove_enemy(enemy : Zombie) ->void:
	enemies.erase(enemy)
	enemy_count_updated.emit()
	
	if enemies.size() == 0:
		if cur_wave_count < wave_count:
			cur_wave_count += 1
			pick_upgrade.emit()
			pause_game()
		else:
			finished_waves.emit()
	

func upgrade_picked() ->void:
	resume_game()
	cur_wave.emit(cur_wave_count)
	next_wave.emit()

func pause_game() ->void:
	player.set_physics_process(false)
	
func resume_game() ->void:
	player.set_physics_process(true)
