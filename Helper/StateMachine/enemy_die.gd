extends State

class_name EnemyDie

@export var blood_fx_scene: PackedScene
@export var enemy : Enemy
@export var vfx_holder : Node2D

func enter() ->void:
	vfx_holder = get_tree().get_first_node_in_group("VFXHolder")
	ScoreManager.update_score(1)
	spawn_blood_fx()
	enemy.call_deferred("queue_free")

func spawn_blood_fx() ->void:
	var blood_fx = blood_fx_scene.instantiate() as BloodSplatterParticle
	blood_fx.global_position = enemy.global_position
	vfx_holder.add_child(blood_fx)
