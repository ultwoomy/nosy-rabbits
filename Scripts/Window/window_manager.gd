extends Node
class_name Window_Manager
var minimized_windows = 0
@export var desktop_bar : Desktop_Bar

signal window_minimized(ref)

func _ready() -> void:
	for child in get_children():
		if child is Base_Window:
			child.minimize_window.connect(_minimize_window)
			child.delete_window.connect(_on_window_delete)
	
func _add_window(id : String):
	var new_scene = load("res://Scenes/Window_Scenes/" + id.to_lower() + ".tscn").instantiate()
	new_scene.position = Vector2(100,100)
	new_scene.minimize_window.connect(_minimize_window)
	add_child(new_scene)
	
func _add_window_maximize(ref):
	add_child(ref)
	ref._maximize()

func _minimize_window(ref : Base_Window):
	ref._pause()
	remove_child(ref)
	desktop_bar.add_child(ref)
	window_minimized.emit(ref)

func _on_window_delete(ref : Base_Window):
	ref.queue_free()
