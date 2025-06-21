extends Node2D
class_name Desktop_Bar
@export var window_manager : Window_Manager
var minimized_windows : Array = [null,null,null,null,null]
var num_windows : int = 0
var index : int = 0
var corresponding_buttons : Array = [null,null,null,null,null]
var button = load("res://Scenes/minimized_window_button.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_manager.window_minimized.connect(self._check_children)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _check_children(ref : Base_Window):
	index = 0
	for child in minimized_windows:
		if child == null:
			break
		else:
			index += 1
	num_windows += 1
	minimized_windows[index] = ref
	ref.hide()
	var cbutton = button.instantiate()
	add_child(cbutton)
	cbutton.position = Vector2(170 + 20 * (index),1)
	cbutton.id = index
	cbutton.start_maximize.connect(self._max)
	corresponding_buttons[index] = cbutton
		
func _max(id):
	if null == minimized_windows[id]:
		return
	var ref = minimized_windows[id]
	minimized_windows[id] = null
	remove_child(ref)
	window_manager._add_window_maximize(ref)
	var old_button = corresponding_buttons[id]
	corresponding_buttons[id] = null
	old_button.queue_free()
	num_windows -= 1
