extends State

class_name EnemyFollow

@export var enemy : Zombie

var target : CharacterBody2D


func enter() ->void:
	target = enemy.get_target()
