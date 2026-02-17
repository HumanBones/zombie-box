extends Node

signal shake(amount: float)

var bullet_hit_amount: float = 0.4
var bullet_crit_amount: float = 0.8
var player_hit_amount: float = 1.0
var bullet_shot_amount: float = 0.3

func bullet_hit_shake() ->void:
	shake.emit(bullet_hit_amount)
	
func crit_bullet_hit_shake() ->void:
	shake.emit(bullet_crit_amount)
	
func player_hit_shake() ->void:
	shake.emit(player_hit_amount)

func bullet_shot_shake() ->void:
	shake.emit(bullet_shot_amount)
