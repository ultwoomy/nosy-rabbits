extends Node
class_name State_Manager
@export var init_state : State
@export var rabbit : Rabbit
var states:Dictionary = {}
var current_state : State
signal state_changed

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(_on_child_transition)
			child.rabbit = rabbit

	if init_state:
		init_state._enter()
		current_state = init_state

func _on_child_transition(new_state_name):
	#if state != current_state:
		#return
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	if current_state:
		current_state._exit()
	new_state._enter()
	current_state = new_state
	state_changed.emit() 
	
func _tick():
	current_state.tick()
func _process(delta: float) -> void:
	current_state.update(delta)
