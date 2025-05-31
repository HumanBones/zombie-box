extends Node

signal next_wave
signal pick_upgrade
signal finished_waves
signal enemy_count_updated

var wave_count : int = 2
var enemies : Array[Zombie]
var cur_wave_count : int

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
			print("wave_count")
			print(cur_wave_count)
		else:
			finished_waves.emit()
	
