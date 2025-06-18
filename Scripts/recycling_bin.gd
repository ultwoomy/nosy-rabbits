extends Node
class_name Recycling_Bin
@onready var bin_button : TextureButton = $Bin_Button
var recycling_hp = 6000
var cooldown = 0
var exceptions : Array = []

signal _add_recycle_bin


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bin_button_pressed() -> void:
	_add_recycle_bin.emit()
