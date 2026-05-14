extends Node2D

class_name EnemyAttackManager

@onready var timer: Timer = $Timer
@onready var enemy_bullet_shooter: BulletShooter = $EnemyBulletShooter


var attack_speed: float
var attack_dmg: float
var can_attack: bool = true
var cur_target: Player


func attack(ranged : bool) ->void:
	if !can_attack or cur_target == null:
		return
		
	can_attack = false
	
	if ranged:
		ranged_attack()
	else:
		melee_attack()
	
	timer.wait_time = attack_speed
	timer.start()

func melee_attack() ->void:
	if cur_target.has_method("take_dmg"):
		cur_target.take_dmg(attack_dmg)
	
func ranged_attack() ->void:
	enemy_bullet_shooter.spawn_bullet()
	enemy_bullet_shooter.set_shoot(false)

func _on_timer_timeout() ->void:
	can_attack = true

func get_bullet_direction() ->Vector2:
	var target = cur_target
	if target == null:
		return Vector2.ZERO
		
	return (target.global_position - get_parent().global_position).normalized()

func set_cur_target(target : CharacterBody2D) ->void:
	cur_target = target
