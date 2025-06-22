extends Control
@onready var text : Label = $Label
var hand_cursor
var point_cursor
var deny_cursor
var cursor_size
@export var size_change : Size_Change

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size_change.update_size.connect(set_cursor_size)
	if Gvars.win_status == "win":
		text.text = "You succesfully turned off your pc.\n\nGreat work, I think.\n\nYou Won In: " + str(Gvars.score) + " seconds\n\nAgain?"
	else:
		text.text = "The rabbits stared at you so much you died\n\nLmao\n\nYou Lived For: " + str(Gvars.score) + " seconds\n\nAgain?"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	Gvars._reset_hp()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func set_cursor_size(screen_size):
	print(screen_size.y)
	if screen_size.y >= 1280:
		hand_cursor = load("res://Sprites/Mouse Icons/Size2/Hand.png")
		point_cursor = load("res://Sprites/Mouse Icons/Size2/Pointer.png")
		deny_cursor = load("res://Sprites/Mouse Icons/Size2/Prohibited.png")
		cursor_size = 64
		set_point()
	elif screen_size.y >= 640:
		hand_cursor = load("res://Sprites/Mouse Icons/Size2/Hand.png")
		point_cursor = load("res://Sprites/Mouse Icons/Size2/Pointer.png")
		deny_cursor = load("res://Sprites/Mouse Icons/Size2/Prohibited.png")
		cursor_size = 32
		set_point()
	else:
		hand_cursor = load("res://Sprites/Mouse Icons/Size1/Hand.png")
		point_cursor = load("res://Sprites/Mouse Icons/Size1/Pointer.png")
		deny_cursor = load("res://Sprites/Mouse Icons/Size1/Prohibited.png")
		cursor_size = 8
		set_point()

func set_point():
	Input.set_custom_mouse_cursor(point_cursor, Input.CURSOR_ARROW, Vector2(cursor_size/2, cursor_size/2))
