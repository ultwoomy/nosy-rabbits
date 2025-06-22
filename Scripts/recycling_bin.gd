extends Node
class_name Recycling_Bin
@onready var bin_button : TextureButton = $Bin_Button
@export var window_manager : Window_Manager
var recycling_hp = 6000
var cooldown = 0
var exceptions : Array = []

signal _add_recycle_bin


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var create = true
	for child in get_children():
		if child is Recycling:
			create = false
	for child in window_manager.get_children():
		if child is Recycling:
			create = false
	if recycling_hp <= 0:
		create = false
	if create:
		if cooldown < 100:
			cooldown += 0.1


func _on_bin_button_pressed() -> void:
	_add_recycle_bin.emit()
