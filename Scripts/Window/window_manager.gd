extends Node
class_name Window_Manager
var minimized_windows = 0
@export var desktop_bar : Desktop_Bar
@export var recycling_bin : Recycling_Bin

signal window_minimized(ref)

func _ready() -> void:
	recycling_bin._add_recycle_bin.connect(self._create_recycling_bin)
	for child in get_children():
		if child is Base_Window:
			child.minimize_window.connect(_minimize_window)
			child.delete_window.connect(_on_window_delete)
	
func _add_window(id : String):
	var new_scene = load("res://Scenes/Window_Scenes/" + id.to_lower() + ".tscn").instantiate()
	if new_scene is Recycling:
		new_scene._set_hp(recycling_bin.recycling_hp)
	new_scene.position = Vector2(100,100)
	print(new_scene.scale)
	new_scene.minimize_window.connect(_minimize_window)
	new_scene.delete_window.connect(_on_window_delete)
	add_child(new_scene)
	
func _add_window_maximize(ref):
	add_child(ref)
	ref.show()
	ref._maximize()

func _minimize_window(ref : Base_Window):
	ref._pause()
	remove_child(ref)
	desktop_bar.add_child(ref)
	window_minimized.emit(ref)

func _on_window_delete(ref : Base_Window):
	if ref is Recycling:
		recycling_bin.recycling_hp = ref.get_hp()
	ref.queue_free()

func _create_recycling_bin():
	var create = true
	for child in get_children():
		if child is Recycling:
			create = false
	if create:
		_add_window("recycling")
