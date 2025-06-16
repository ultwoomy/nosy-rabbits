extends Node2D
class_name Desktop_Bar
@export var window_manager : Window_Manager
var minimized_windows : Array = []
var corresponding_buttons : Array = []
var button = load("res://Scenes/minimized_window_button.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_manager.window_minimized.connect(self._check_children)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _check_children(ref : Base_Window):
	minimized_windows.append(ref)
	var cbutton = button.instantiate()
	add_child(cbutton)
	cbutton.position = Vector2(190 + 20 * (minimized_windows.size() - 1),146)
	cbutton.id = minimized_windows.size() - 1
	cbutton.start_maximize.connect(self._max)
	corresponding_buttons.append(cbutton)
	
func _max(id):
	var ref = minimized_windows[id]
	minimized_windows.remove_at(id)
	remove_child(ref)
	window_manager._add_window_maximize(ref)
	var old_button = corresponding_buttons[id]
	corresponding_buttons.remove_at(id)
	old_button.queue_free()
	for child in corresponding_buttons:
		if child.id > id:
			child.id -= 1
	
