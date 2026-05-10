extends Node

class_name StateMachine

@export var inital_state : State
@export var enemy : Enemy

var cur_state : State
var states : Dictionary = {}

func _ready() -> void:
	enemy.died.connect(enemy_died)
	GameStateManager.game_paused.connect(game_paused)
	GameStateManager.game_resumed.connect(game_resumed)
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
			
	if inital_state:
		inital_state.enter()
		cur_state = inital_state
		
func _process(delta: float) -> void:
	if cur_state:
		cur_state.update(delta)

func _physics_process(delta: float) -> void:
	if cur_state:
		cur_state.physics_update(delta)

func on_child_transition(state: State, new_state_name: String) ->void:
	if state != cur_state:
		return

	change_state(new_state_name)

func change_state(new_state_name : String) ->void:
	var new_state : State = states.get(new_state_name.to_lower())
	
	if !new_state:
		return
		
	if cur_state:
		cur_state.exit()
		
	new_state.enter()
	cur_state = new_state

func game_paused() ->void:
	set_physics_process(false)
	
func game_resumed() ->void:
	set_physics_process(true)

func enemy_died(enemy:Enemy) ->void:
	change_state("die")
	
