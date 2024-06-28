extends Node

class_name FiniteStateMachine
@export var initial_state: State

var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		var element := child as State
		if element != null:
			states[element.name.to_lower()] = element
			element.Transitioned.connect(on_child_transition)
  
	if initial_state:
		var enter_callable: Callable = Callable(initial_state, "enter")
		enter_callable.call_deferred()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func on_child_transition(new_state_name: String) -> void:
	change_state(new_state_name)

func change_state(new_state_name: String) -> void:
	var new_state: State = states.get(new_state_name.to_lower())
	
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
