extends CharacterBody2D

class_name Player

signal player_hit

@export_category("Stats")
@export_group("Start stats")
@export var start_speed : float
@export var start_hp : float
@export var start_attack_speed : float
@export var start_attack_range : float

@export_group("Max stats")
@export var max_hp : float
@export var max_speed : float
@export var max_attack_speed : float
@export var max_attack_range : float

@export_group("HealthBar")
@export var healthbar : HealthBar

@onready var bullet_shooter: BulletShooter = $BulletShooter

var speed : float
var hp : float
var attack_speed : float
var direction : Vector2
var attack_range : float

func _ready() -> void:
	speed = start_speed
	hp = start_hp
	attack_range = start_attack_range
	attack_speed = start_attack_speed
	healthbar_init()
	bullet_shooter.set_attck_speed(attack_speed)

func _physics_process(delta: float) -> void:
	get_input()
	velocity = direction * speed
	
	move_and_slide()

func get_closest_enemy() -> Zombie:
	var closest_enemy : Zombie
	var enemies = get_tree().get_nodes_in_group("Enemy")
	
	enemies = enemies.filter(func(enemy: Zombie):
		return enemy.global_position.distance_squared_to(global_position) < pow(attack_range,2)
	)
	
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(global_position)
		var b_distance = b.global_position.distance_squared_to(global_position)
		return a_distance < b_distance
	)
	
	if enemies.is_empty():
		return null
	
	closest_enemy = enemies[0]
	
	return closest_enemy

func get_input() ->void:
	var input_x = Input.get_axis("left","right")
	var input_y = Input.get_axis("up","down")
	direction = Vector2(input_x,input_y).normalized()
	
func get_bullet_direction() -> Vector2:
	var closes_enemy = get_closest_enemy()
	if closes_enemy == null:
		return Vector2.ZERO
		
	return (closes_enemy.global_position - global_position).normalized()

func healthbar_init() ->void:
	healthbar.set_min_value(0.0)
	healthbar.set_max_value(max_hp)
	
func take_dmg(amount : float) ->void:
	hp -= amount
	player_hit.emit()
	if hp <= 0:
		die()
	healthbar.set_value(hp)
	player_hit_fx()

func die() ->void:
	GameStateManager.set_game_over()
	print("you died")
	set_physics_process(false)
	bullet_shooter.set_shoot(false)

func player_hit_fx() ->void:
	CameraShakeManager.player_hit_shake()
