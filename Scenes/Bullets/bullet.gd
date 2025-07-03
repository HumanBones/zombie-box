extends Area2D

class_name Bullet

@export var default_life_time : float

@onready var timer: Timer = $Timer

var dmg : float
var speed : float
var direction : Vector2
var life_time : float

func _ready() -> void:
	life_time = default_life_time
	timer.wait_time = life_time

func _process(delta: float) -> void:
	
	if direction == Vector2.ZERO:
		return
		
	global_position += speed * delta * direction

func get_dmg() -> float:
	return dmg

func set_dmg(amount : float) -> void:
	dmg = amount
	
func get_speed() -> float:
	return speed

func set_speed(amount : float) -> void:
	speed = amount

func set_size(amount : float) -> void:
	scale = Vector2(amount,amount)

func get_size() -> Vector2:
	return self.scale

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	die()

func _on_timer_timeout() -> void:
	die()
	
func die() ->void:
	call_deferred("queue_free")
	
