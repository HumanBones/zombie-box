extends Camera2D

class_name MainCamera

@export var target: Player
@export var follow_distance: float
@export var speed: float

@export var shake_strength: float
@export var shake_amount: float
@export var shake_decay: float


func _ready() ->void:
	CameraShakeManager.shake.connect(shake)
	if target == null:
		target = get_tree().get_first_node_in_group("Player")

func _process(delta: float) ->void:
	if shake_strength > 0.0:
		var cam_offset = Vector2( randf_range(-1.0,1.0),randf_range(-1.0,1.0)) * shake_amount * shake_strength
		cam_offset = cam_offset.round()
		offset = cam_offset
		shake_strength = max(shake_strength - shake_decay * delta, 0.0)
		
	else:
		offset = Vector2.ZERO
		
		
func _physics_process(delta: float) ->void:
	if target == null:
		return
	
	if global_position.distance_squared_to(target.global_position) > follow_distance*follow_distance:
		global_position = global_position.lerp(target.global_position,delta * speed)
	
func shake(amount: float) ->void:
	shake_strength = amount
