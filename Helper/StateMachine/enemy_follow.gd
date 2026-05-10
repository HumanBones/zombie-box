extends State

class_name EnemyFollow

@onready var navigation_agent_2d: NavigationAgent2D = $"../../NavigationAgent2D"
@export var enemy : Enemy

var target : CharacterBody2D
var direction : Vector2

func enter() ->void:
	if target == null:
		target = get_tree().get_first_node_in_group("Player")

func physics_update(_delta : float) ->void:
	navigation_agent_2d.target_position = target.global_position
	
	if GameStateManager.cur_game_state == GameStateManager.GameState.GAMEOVER:
		transitioned.emit(self,"idle")
	
	if enemy.global_position.distance_squared_to(target.global_position) > enemy.attack_range * enemy.attack_range:
		direction = navigation_agent_2d.get_next_path_position() - enemy.global_position
		direction = direction.normalized()
		enemy.velocity = direction * enemy.speed
	
	else:
		enemy.velocity = Vector2.ZERO
		transitioned.emit(self,"attack")
		
		
	enemy.move_and_slide()
