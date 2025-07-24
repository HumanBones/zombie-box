extends Node

signal next_wave
signal pick_upgrade
signal finished_waves
signal enemy_count_updated
signal cur_wave(amount:int)
signal scaled(stat:String,amount:float)

@export_category("Enemy scale amount")
var health_scale_amount : float = 0.1
var speed_scale_amount : float = 0.1
var dmg_scale_amount : float = 0.1

@export_category("Enemy cur scale")
var cur_health_scale : float = 1.0
var cur_speed_scale : float = 1.0
var cur_dmg_scale: float = 1.0

var player : Player
var wave_count : int = 1
var enemies : Array[Zombie]
var cur_wave_count : int

func _ready() -> void:
	PowerUpManager.powerup_used.connect(upgrade_picked)
	scaled.connect(debug_print_stats)
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
	scale_dif()
	next_wave.emit()

func pause_game() ->void:
	player.call_deferred("set_physics_process", false)
	
func resume_game() ->void:
	player.set_physics_process(true)

func scale_enemy_hp() ->void:
	var amount = health_scale_amount * wave_count
	cur_health_scale += amount
	scaled.emit("Health",amount)

func scale_enemy_speed() ->void:
	var amount = speed_scale_amount * wave_count
	cur_speed_scale += amount
	scaled.emit("Speed",amount)
	
func scale_enemy_dmg() ->void:
	var amount = dmg_scale_amount * wave_count
	cur_dmg_scale += amount
	scaled.emit("Damage",amount)
	
func get_enemy_hp_scale() ->float:
	return cur_health_scale

func get_enemy_speed_scale() ->float:
	return cur_speed_scale

func get_enemy_dmg_scale() ->float:
	return cur_dmg_scale

func scale_dif() ->void:
	scale_enemy_dmg()
	scale_enemy_hp()
	scale_enemy_speed()

func debug_print_stats(stat: String, amount: float) ->void:
	print(stat + " : " + str(amount))
	
