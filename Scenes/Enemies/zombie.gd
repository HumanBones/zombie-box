extends CharacterBody2D

class_name Zombie

signal died

@export_category("Stats")
@export_group("Start Stats")
@export var start_speed: float
@export var start_hp: float
@export var start_attack_range: float

@export var blood_fx_scene: PackedScene

@onready var blood_hit: CPUParticles2D = $BloodHit
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var attack_manager: EnemyAttackManager = $AttackManager
@onready var health_bar: HealthBar = $HealthBar

var speed: float
var hp: float
var attack_speed: float
var direction: Vector2
var target: Player
var attack_range : float

func _ready() ->void:
	if target == null:
		target = get_tree().get_first_node_in_group("Player")
	speed = start_speed * SpawnManager.cur_speed_scale
	attack_range = start_attack_range
	init_healthbar()
	GameStateManager.game_paused.connect(game_paused)
	GameStateManager.game_resumed.connect(game_resumed)

func init_healthbar() ->void:
	start_hp = start_hp * SpawnManager.cur_health_scale
	hp = start_hp
	health_bar.set_max_value(start_hp)
	health_bar.set_value(hp)
	health_bar.update_min_max_value()
	health_bar.hide()

func _physics_process(delta: float) ->void:
	
	navigation_agent_2d.target_position = target.global_position
	
	if global_position.distance_squared_to(target.global_position) > attack_range * attack_range:
		direction = navigation_agent_2d.get_next_path_position() - global_position
		direction = direction.normalized()
		velocity = direction * speed
	
	else:
		velocity = Vector2.ZERO
		attack_manager.attack()
		
	move_and_slide()

func take_dmg(dmg: float) ->void:
	health_bar.show()
	hp -= dmg
	health_bar.set_value(hp)
	if hp < 0:
		died.emit(self)
		health_bar.hide()
		die()

func die() ->void:
	ScoreManager.update_score(1)
	spawn_blood_fx()
	call_deferred("queue_free")

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullets"):
		show_hit_effect(area.global_position, -area.direction.normalized())
		take_dmg(area.get_dmg())
		area.die()

func show_hit_effect(pos: Vector2, dir: Vector2) ->void:
	blood_hit.global_position = pos
	blood_hit.rotation = dir.angle()
	blood_hit.show()
	blood_hit.emitting = true
	CameraShakeManager.bullet_hit_shake()

func spawn_blood_fx() ->void:
	var blood_fx = blood_fx_scene.instantiate() as BloodSplatterParticle
	blood_fx.global_position = self.global_position
	get_parent().add_child(blood_fx)

func game_paused() ->void:
	set_physics_process(false)
	attack_manager.can_attack = false
	
func game_resumed() ->void:
	set_physics_process(true)
	attack_manager.can_attack = true
