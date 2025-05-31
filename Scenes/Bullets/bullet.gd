extends Area2D

class_name Bullet

@export var max_speed : float
@export var max_dmg : float
@export var life_time : float

@onready var timer: Timer = $Timer

var dmg : float
var speed : float
var direction : Vector2

func _ready() -> void:
	speed = max_speed
	dmg = max_dmg
	timer.wait_time = life_time

func _process(delta: float) -> void:
	
	if direction == Vector2.ZERO:
		print("Direction not set")
		return
		
	global_position += speed * delta * direction

func get_dmg() -> float:
	return dmg

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	die()

func _on_timer_timeout() -> void:
	die()
	
func die() ->void:
	call_deferred("queue_free")
	
