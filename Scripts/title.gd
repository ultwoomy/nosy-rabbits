extends Control
var hand_cursor
var point_cursor
var deny_cursor
var cursor_size
@export var size_change : Size_Change
@export var settings_panel : Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size_change.update_size.connect(set_cursor_size)
	settings_panel.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func set_hand():
	Input.set_custom_mouse_cursor(hand_cursor, Input.CURSOR_ARROW, Vector2(cursor_size/2, cursor_size/2))
	print("sh")
	
func set_point():
	Input.set_custom_mouse_cursor(point_cursor, Input.CURSOR_ARROW, Vector2(cursor_size/2, cursor_size/2))
	print("sp")
	
func set_x():
	Input.set_custom_mouse_cursor(deny_cursor, Input.CURSOR_ARROW, Vector2(cursor_size/2, cursor_size/2))
	print("sx")

func set_cursor_size(screen_size):
	print(screen_size.y)
	if screen_size.y > 1280:
		hand_cursor = load("res://Sprites/Mouse Icons/Size2/Hand.png")
		point_cursor = load("res://Sprites/Mouse Icons/Size2/Pointer.png")
		deny_cursor = load("res://Sprites/Mouse Icons/Size2/Prohibited.png")
		cursor_size = 64
		set_point()
	else:
		hand_cursor = load("res://Sprites/Mouse Icons/Size1/Hand.png")
		point_cursor = load("res://Sprites/Mouse Icons/Size1/Pointer.png")
		deny_cursor = load("res://Sprites/Mouse Icons/Size1/Prohibited.png")
		cursor_size = 8
		set_point()



func _on_settings_pressed() -> void:
	settings_panel.show()
	settings_panel.position = Vector2(10,10)


func _on_exit_button_pressed() -> void:
	settings_panel.hide()
	settings_panel.position = Vector2(500,10)


func _on_h_slider_value_changed(value: float) -> void:
	Gvars.volume = value
