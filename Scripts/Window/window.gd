extends Node
class_name Base_Window
@onready var uibar : Control = $Uibar
@onready var hitbox : Area2D = $Hitbox
@onready var damage : AnimatedSprite2D = $Damage
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
var immune : bool = false
var mouse_down = false
var click_ban = false

var in_drag_bar : bool = false
var currently_dragging : bool = false
var minimizing : bool = false
var maximizing : bool = false
var offset : Vector2 = Vector2(0,0)
var saved_position : Vector2 = Vector2(0,0)

var prohibit_timer : Timer = Timer.new()

signal delete_window(id)
signal minimize_window(id)
signal window_maximized(id)
signal focus_window(id)
signal minimize_completed(id)
signal set_to_pointer
signal set_to_hand
signal set_to_prohibit

func _enter():
	active = true
	damage.hide()
	uibar.get_child(1).show_behind_parent = true
	uibar.get_child(2).show_behind_parent = true
	uibar.get_child(3).show_behind_parent = true
	if not uibar.mouse_entered.is_connected(self._mouse_enter_hitbox):
		uibar.mouse_entered.connect(self._mouse_enter_hitbox)
		uibar.mouse_exited.connect(self._mouse_exit_hitbox)
		uibar.get_child(1).pressed.connect(self._on_minimize_pressed)
		uibar.get_child(2).pressed.connect(self._on_delete_pressed)
		uibar.get_child(3).pressed.connect(self.swap_prohibited_cursor)
		prohibit_timer.autostart = false
		prohibit_timer.one_shot = true
		prohibit_timer.timeout.connect(self._swap_back)
		add_child(prohibit_timer)
		
func swap_prohibited_cursor():
	set_to_prohibit.emit()
	prohibit_timer.start(1)
	
func _swap_back():
	if in_drag_bar:
		set_to_hand.emit()
	else:
		set_to_pointer.emit()
	
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
	set_to_hand.emit()
	
func _mouse_exit_hitbox() -> void:
	in_drag_bar = false
	set_to_pointer.emit()
	
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


func _on_delete_pressed() -> void:
	if deletable:
		_exit()
	else:
		set_to_prohibit.emit()
		prohibit_timer.start(1)
	
func _on_minimize_pressed() -> void:
	if minimizable:
		minimize_window.emit(self)
	else:
		set_to_prohibit.emit()
		prohibit_timer.start(1)

func _maximize():
	self.position = saved_position + Vector2(0,200)
	self.scale = Vector2(0.4,0.4)
	maximizing = true

func _take_damage(d):
	if not immune:
		hp -= d
	if hp <= 0:
		_exit()
	if hp <= max_hp/4:
		damage.show()
		damage.frame = 1
	elif hp <= max_hp/2:
		damage.show()
		damage.frame = 0
	else:
		damage.hide()
