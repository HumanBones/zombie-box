extends Node2D

class_name EnemyAttackManager

@export var max_attack_speed: float
@export var max_attack_dmg: float
@export var is_ranged: bool = false

@onready var timer: Timer = $Timer

var attack_speed: float
var attack_dmg: float
var can_attack: bool = true
var cur_target: Player

func _ready() ->void:
	attack_speed = max_attack_speed
	attack_dmg = max_attack_dmg * SpawnManager.cur_dmg_scale
	timer.wait_time = attack_speed

func attack() ->void:
	if !can_attack or cur_target == null:
		return
		
	can_attack = false
	if cur_target.has_method("take_dmg"):
		cur_target.take_dmg(attack_dmg)
		
	timer.start()

func _on_timer_timeout() ->void:
	can_attack = true

func _on_hurtbox_area_entered(area: Area2D) ->void:
	if area.get_parent().is_in_group("Player"):
		cur_target = area.get_parent()

func _on_hurtbox_area_exited(area: Area2D) ->void:
	if area.get_parent().is_in_group("Player"):
		cur_target = null
