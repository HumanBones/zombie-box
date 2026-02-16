extends Node2D

class_name BulletShooter

signal bullet_spawned

@export var bullet_scene : PackedScene
@export var parent : Node2D

@export_group("Start stats")
@export var start_attack_speed : float
@export var start_bullet_size : float
@export var start_bullet_speed : float
@export var start_bullet_dmg : float

@export_group("Max stats")
@export var max_attack_speed : float
@export var max_bullet_size : float
@export var max_bullet_speed : float
@export var max_bullet_dmg : float

@export var gun_point : Marker2D

@onready var timer: Timer = $Timer
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var light_timer: Timer = $LightTimer

var bullet_holder : Node2D
var attack_speed : float
var can_shott : bool = true
var bullet_speed : float
var bullet_size : float
var bullet_dmg : float

func _ready() -> void:
	bullet_speed = start_bullet_speed
	bullet_size = start_bullet_size
	bullet_dmg = start_bullet_dmg
	attack_speed = start_attack_speed
	timer.wait_time = attack_speed
	
	if gun_point != null:
		point_light_2d.global_position = gun_point.global_position
	
	bullet_holder = get_tree().get_first_node_in_group("BulletHolder")


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
	
	#CameraShakeManager.bullet_shot_shake()
	
	point_light_2d.rotation = bullet_direction.angle()
	show_flash()

func set_attck_speed(attack_spd :float) ->void:
	attack_speed = attack_spd
	attack_speed = clamp(attack_spd,start_attack_speed,max_attack_speed)
	timer.wait_time = attack_speed

func _on_timer_timeout() -> void:
	spawn_bullet()

func show_flash() ->void:
	point_light_2d.show()
	light_timer.start()
	

func _on_light_timer_timeout() -> void:
	point_light_2d.hide()
