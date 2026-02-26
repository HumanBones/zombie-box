extends Node

class_name StateMachine

@export var inital_state : State

var cur_state : State
var states : Dictionary = {}

func _ready() -> void:
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
		
	var new_state = state.get(new_state_name.to_lower())
	
	if !new_state_name:
		return
