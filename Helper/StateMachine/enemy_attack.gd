extends State

class_name EnemyAttack

@onready var attack_manager: EnemyAttackManager = $"../../AttackManager"
@export var enemy : Enemy

var target : CharacterBody2D

func enter() ->void:
	if target == null:
		target = get_tree().get_first_node_in_group("Player")
	attack_manager.set_cur_target(enemy.target)

func physics_update(_delta : float) ->void:
	if GameStateManager.cur_game_state == GameStateManager.GameState.GAMEOVER:
		transitioned.emit(self,"idle")
	if enemy.global_position.distance_squared_to(target.global_position) > enemy.attack_range * enemy.attack_range:
		transitioned.emit(self,"follow")
	else:
		attack_manager.attack(enemy.enemy_type.is_ranged)

func exit() ->void:
		attack_manager.set_cur_target(null)
	
