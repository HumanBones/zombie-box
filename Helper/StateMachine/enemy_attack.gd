extends State

class_name EnemyAttack

@onready var attack_manager: EnemyAttackManager = $"../../AttackManager"
@export var enemy : Enemy

var target : CharacterBody2D

func enter() ->void:
	if target == null:
		target = get_tree().get_first_node_in_group("Player")
	attack_manager.attack()

func physics_update(_delta : float) ->void:
	if enemy.global_position.distance_squared_to(target.global_position) > enemy.attack_range * enemy.attack_range:
		transitioned.emit(self,"follow")
	else:
		attack_manager.attack()
