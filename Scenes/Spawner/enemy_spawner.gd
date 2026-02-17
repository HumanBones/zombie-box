extends Node2D

class_name EnemySpawner

signal finished_spawning

@export var enemy_scene: PackedScene
@export var spawn_interval: float
@export var spawn_range: float
@export var max_enemy_count: int

@onready var timer: Timer = $Timer

var enemy_holder: Node2D
var can_spawn: bool = true
var cur_enemy_count: int = 0

func _ready() -> void:
	enemy_holder = get_tree().get_first_node_in_group("EnemyHolder")
	timer.wait_time = spawn_interval
	SpawnManager.next_wave.connect(start_next_wave)
	GameStateManager.game_paused.connect(game_paused)
	GameStateManager.game_resumed.connect(game_resumed)

func _process(delta: float) -> void:
	if !can_spawn:
		timer.paused = true
	else:
		timer.paused = false

func spawn_enemy() ->void:
	if cur_enemy_count >= max_enemy_count:
		finished_spawning.emit()
		return
	var enemy_instance = enemy_scene.instantiate() as Zombie
	enemy_instance.global_position = get_random_spawn_point()
	enemy_instance.died.connect(SpawnManager.remove_enemy)
	enemy_holder.add_child(enemy_instance)
	cur_enemy_count += 1
	SpawnManager.add_enemy(enemy_instance)

func remove_enemy_from_list(instance: Zombie) ->void:
	if instance in SpawnManager.enemies:
		SpawnManager.remove_enemy(instance)

func stop_spawn() ->void:
	can_spawn = false

func start_spwn() -> void:
	can_spawn = true

func get_random_spawn_point() -> Vector2:
	var spawn_point : Vector2
	var angle = randf() * TAU
	var distance = randf() * spawn_range
	spawn_point = Vector2(cos(angle), sin(angle)) * distance
	
	return spawn_point + global_position

func start_next_wave() ->void:
	cur_enemy_count = 0
	can_spawn = true

func _on_timer_timeout() -> void:
	spawn_enemy()

func game_paused() ->void:
	timer.paused = true
	can_spawn = false
	
func game_resumed() ->void:
	timer.paused = false
	can_spawn = true
