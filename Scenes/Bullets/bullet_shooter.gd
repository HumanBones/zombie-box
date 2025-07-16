extends Node2D

class_name BulletShooter

signal bullet_spawned

@export var bullet_scene : PackedScene
@export var max_attack_speed : float
@export var parent : Node2D

@export var max_bullet_size : float
@export var max_bullet_speed : float
@export var max_bullet_dmg : float

@onready var timer: Timer = $Timer

var bullet_holder : Node2D
var attack_speed : float
var can_shott : bool = true
var bullet_speed : float
var bullet_size : float
var bullet_dmg : float

func _ready() -> void:
	bullet_speed = max_bullet_speed
	bullet_size = max_bullet_size
	bullet_dmg = max_bullet_dmg
	
	bullet_holder = get_tree().get_first_node_in_group("BulletHolder")
	if attack_speed == null or 0:
		attack_speed = max_attack_speed
		timer.wait_time = attack_speed

func set_shoot(can_shoot : bool) -> void:
	if can_shoot:
		timer.start()
	else:
		timer.stop()

func spawn_bullet() ->void:
	var bullet_direction = parent.get_bullet_direction()
	if bullet_direction == Vector2.ZERO:
		return
		
	var bullet_instance = bullet_scene.instantiate() as Bullet
	bullet_instance.direction = bullet_direction
	bullet_instance.global_position = parent.global_position
	bullet_instance.set_dmg(bullet_dmg)
	bullet_instance.set_size(bullet_size)
	bullet_instance.set_speed(bullet_speed)
	bullet_holder.add_child(bullet_instance)
	bullet_spawned.emit()

func set_attck_speed(attack_spd :float) ->void:
	attack_speed = attack_spd
	timer.wait_time = attack_speed

func _on_timer_timeout() -> void:
	spawn_bullet()
