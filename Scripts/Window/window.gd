extends Node
class_name Base_Window
@onready var uibar : Control = $Uibar

@export var size : Vector2

var id : String = "BASE"
var active : bool = false
var shape : Sprite2D
var minimized : bool = false
var minimizable : bool = true
var draggable : bool = true
var hp : int = 100
var deletable : bool = true

var in_drag_bar : bool = false
var currently_dragging : bool = false
var minimizing : bool = false
var maximizing : bool = false
var offset : Vector2 = Vector2(0,0)
var saved_position : Vector2 = Vector2(0,0)

signal delete_window(id)
signal minimize_window(id)
signal window_maximized(id)

func _enter():
	active = true
	
func _exit():
	delete_window.emit(self)
	
func _on_damage(damage):
	pass

func _pause():
	pass

func _set_minimizable_status(x):
	minimizable = x

func _mouse_enter_hitbox() -> void:
	in_drag_bar = true
	
func _mouse_exit_hitbox() -> void:
	in_drag_bar = false
	
func _process(delta: float) -> void:
	if(Input.is_mouse_button_pressed(1) and in_drag_bar and draggable and not currently_dragging and not minimizing and not maximizing):
		offset = Vector2(get_viewport().get_mouse_position().x-self.position.x+50,get_viewport().get_mouse_position().y-self.position.y+50)
		currently_dragging = true
	elif(not Input.is_mouse_button_pressed(1)):
		currently_dragging = false
		
	if currently_dragging:
		self.position = Vector2(get_viewport().get_mouse_position().x+50,get_viewport().get_mouse_position().y+50)-offset
	
	if minimizing:
		maximizing = false
		self.position = self.position + Vector2(0,10)
		self.scale = self.scale - Vector2(0.03,0.03)
		if self.position.y > 160:
			minimizing = false
			minimized = true
			minimize_window.emit(self)
			
	if maximizing:
		minimizing = false
		self.position = self.position - Vector2(0,10)
		if self.scale.x < 1:
			self.scale = self.scale + Vector2(0.03,0.03)
		if self.position.y <= saved_position.y:
			maximizing = false
			window_maximized.emit(self)


func _on_delete_pressed() -> void:
	_exit()
	
func _on_minimize_pressed() -> void:
	if minimizable:
		minimizing = true
		saved_position = self.position

func _maximize():
	self.position = saved_position + Vector2(0,200)
	self.scale = Vector2(0.4,0.4)
	maximizing = true
