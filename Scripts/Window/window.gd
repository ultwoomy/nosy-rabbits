extends Node
class_name Base_Window
@onready var uibar : Control = $Uibar
@onready var hitbox : Area2D = $Hitbox
@export var size : Vector2

var id : String = "BASE"
var active : bool = false
var shape : Sprite2D
var minimized : bool = false
var minimizable : bool = true
var draggable : bool = true
var max_hp : int = 2000
var hp : int = 2000
var deletable : bool = true
var mouse_down = false
var click_ban = false

var in_drag_bar : bool = false
var currently_dragging : bool = false
var minimizing : bool = false
var maximizing : bool = false
var offset : Vector2 = Vector2(0,0)
var saved_position : Vector2 = Vector2(0,0)

signal delete_window(id)
signal minimize_window(id)
signal window_maximized(id)
signal focus_window(id)
signal minimize_completed(id)

func _enter():
	active = true
	if not uibar.mouse_entered.is_connected(self._mouse_enter_hitbox):
		uibar.mouse_entered.connect(self._mouse_enter_hitbox)
		uibar.mouse_exited.connect(self._mouse_exit_hitbox)
		uibar.get_child(1).pressed.connect(self._on_minimize_pressed)
		uibar.get_child(2).pressed.connect(self._on_delete_pressed)
	
func _exit():
	delete_window.emit(self)
	
func _on_damage(damage):
	pass

func _pause():
	pass
	
func _set_hp(new_hp):
	max_hp = new_hp
	hp = new_hp

func get_hp():
	return hp

func _set_minimizable_status(x):
	minimizable = x

func _mouse_enter_hitbox() -> void:
	in_drag_bar = true
	
func _mouse_exit_hitbox() -> void:
	in_drag_bar = false
	
func _process(delta: float) -> void:
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and not in_drag_bar:
		click_ban = true
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and not click_ban:
		mouse_down = true
		focus_window.emit(self)
	if Input.is_action_just_released("left_mouse"):
		click_ban = false
		mouse_down = false
	if(mouse_down and in_drag_bar and draggable and not currently_dragging and not minimizing and not maximizing):
		offset = Vector2(get_viewport().get_mouse_position().x-self.position.x+50,get_viewport().get_mouse_position().y-self.position.y+50)
		currently_dragging = true
	elif(not mouse_down):
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
			minimize_completed.emit(self)
			
	if maximizing:
		minimizing = false
		self.position = self.position - Vector2(0,10)
		if self.scale.x < 1:
			self.scale = self.scale + Vector2(0.03,0.03)
		if self.position.y <= saved_position.y:
			maximizing = false
			window_maximized.emit(self)
			
	if hitbox.has_overlapping_areas():
		var rabbits = hitbox.get_overlapping_areas()
		for r in rabbits:
			if r is Rabbit_Hitbox:
				hp -= r.damage
				if hp <= 0:
					_exit()


func _on_delete_pressed() -> void:
	if deletable:
		_exit()
	
func _on_minimize_pressed() -> void:
	if minimizable:
		minimize_window.emit(self)

func _maximize():
	self.position = saved_position + Vector2(0,200)
	self.scale = Vector2(0.4,0.4)
	maximizing = true
