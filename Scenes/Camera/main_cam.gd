extends Camera2D

class_name MainCamera

@export var target : Player
@export var follow_distance : float
@export var speed : float

func _ready() -> void:
	if target == null:
		target = get_tree().get_first_node_in_group("Player")


func _physics_process(delta: float) -> void:
	if target == null:
		return
	
	if global_position.distance_squared_to(target.global_position) > follow_distance*follow_distance:
		global_position = global_position.lerp(target.global_position,delta * speed)
	
