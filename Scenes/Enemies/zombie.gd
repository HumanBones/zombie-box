extends CharacterBody2D

class_name Zombie

signal died

@export_category("Stats")
@export_group("Max Stats")
@export var max_speed : float
@export var max_hp : float
@export var attack_range : float

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var attack_manager: EnemyAttackManager = $AttackManager
@onready var health_bar: HealthBar = $HealthBar

var speed : float
var hp : float
var attack_speed : float
var direction : Vector2
var target : Player

func _ready() -> void:
	if target == null:
		target = get_tree().get_first_node_in_group("Player")
	speed = max_speed * SpawnManager.cur_speed_scale
	hp = max_hp * SpawnManager.cur_health_scale
	health_bar.hide()
	health_bar.set_max_value(max_hp)
	health_bar.set_value(hp)

func _physics_process(delta: float) -> void:
	
	navigation_agent_2d.target_position = target.global_position
	
	if global_position.distance_squared_to(target.global_position) > attack_range * attack_range:
		direction = navigation_agent_2d.get_next_path_position() - global_position
		direction = direction.normalized()
	
		velocity = direction * speed
	
	else:
		velocity = Vector2.ZERO
		attack_manager.attack()
		
	move_and_slide()

func take_dmg(dmg : float) ->void:
	health_bar.show()
	hp -= dmg
	health_bar.set_value(hp)
	if hp < 0:
		died.emit(self)
		health_bar.hide()
		die()

func die() -> void:
	call_deferred("queue_free")

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullets"):
		take_dmg(area.get_dmg())
		area.die()
