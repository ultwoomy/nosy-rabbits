extends Node
class_name Window_Manager
var minimized_windows = 0
@export var desktop_bar : Desktop_Bar
@export var recycling_bin : Recycling_Bin
@export var rabbits : Array[Rabbit] = []

signal window_minimized(ref)

func _ready() -> void:
	recycling_bin._add_recycle_bin.connect(self._create_recycling_bin)
	for child in get_children():
		if child is Base_Window:
			child.minimize_window.connect(_minimize_window)
			child.delete_window.connect(_on_window_delete)
	
func _add_window(id : String):
	var new_scene
	if ResourceLoader.exists("res://Scenes/Window_Scenes/" + id.to_lower() + ".tscn"):
		new_scene = load("res://Scenes/Window_Scenes/" + id.to_lower() + ".tscn").instantiate()
	else:
		return
	if new_scene is Recycling:
		new_scene._set_hp(recycling_bin.recycling_hp)
		new_scene.create_window.connect(self._add_window)
		new_scene.exceptions = recycling_bin.exceptions
		new_scene.recharge = recycling_bin.cooldown
	if new_scene is Png_Carrot:
		for child in rabbits:
			child.charmed = new_scene
		
	new_scene.position = Vector2(100,100)
	new_scene.minimize_window.connect(_minimize_window)
	new_scene.minimize_completed.connect(_complete_minimization)
	new_scene.delete_window.connect(_on_window_delete)
	new_scene.focus_window.connect(_focus_child)
	add_child(new_scene)
	new_scene._enter()
	
	
func _add_window_maximize(ref):
	add_child(ref)
	ref.show()
	ref._maximize()

func _minimize_window(ref : Base_Window):
	if desktop_bar.minimized_windows.size() < 4:
		ref.minimizing = true
		ref.saved_position = ref.position
			
func _complete_minimization(ref : Base_Window):
	ref._pause()
	remove_child(ref)
	desktop_bar.add_child(ref)
	window_minimized.emit(ref)

func _on_window_delete(ref : Base_Window):
	if ref is Recycling:
		recycling_bin.recycling_hp = ref.get_hp()
		recycling_bin.cooldown = ref.recharge
		ref.create_window.disconnect(self._add_window)
		recycling_bin.exceptions = ref.exceptions
	if ref is Png_Carrot:
		for child in rabbits:
			child.charmed = null
	ref.queue_free()

func _create_recycling_bin():
	var create = true
	for child in get_children():
		if child is Recycling:
			create = false
	for child in desktop_bar.get_children():
		if child is Recycling:
			create = false
	if recycling_bin.recycling_hp <= 0:
		create = false
	if create:
		_add_window("recycling")
		
func _focus_child(id : Base_Window):
	for child in get_children():
		if child == id:
			move_child(child,-1)
