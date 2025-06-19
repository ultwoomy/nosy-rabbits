extends Node2D
var tutorial_hp = 2000
@onready var window_manager : Window_Manager = $Window_Manager
@onready var arrow : Sprite2D = $Arrow
var tutorial_open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_manager.tutorial_closed.connect(check_tutorial_hp)
	#comment below line to test sprite follow mouse
	arrow.hide()

func check_tutorial_hp(hp):
	tutorial_hp = hp
	
func _on_notepad_icon_pressed() -> void:
	if not tutorial_open and tutorial_hp > 0:
		tutorial_open = true
		window_manager._add_window("tutorial")

func _process(delta: float) -> void:
	arrow.position = get_window().get_mouse_position()
