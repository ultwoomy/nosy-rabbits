extends Node2D
var tutorial_hp = 2000
@onready var window_manager : Window_Manager = $Window_Manager
@onready var notepad : TextureButton = $NotepadIcon
@onready var hp_bar : TextureProgressBar = $HpBar
@onready var game_timer : Timer = $Game_Timer
@onready var power : Button = $Power
var rabbits : Array[Rabbit] = []
var tutorial_open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rabbits.append(get_child(1))
	for r in rabbits:
		r.born.connect(_activate_rabbit)
	window_manager.tutorial_closed.connect(check_tutorial_hp)
	hp_bar.max_value = Gvars.player_hp_max

func check_tutorial_hp(hp):
	tutorial_hp = hp
	
func _on_notepad_icon_pressed() -> void:
	if not tutorial_open and tutorial_hp > 0:
		tutorial_open = true
		window_manager._add_window("tutorial")
		notepad.hide()
		game_timer.start()
		for r in rabbits:
			r._activate()
		
func _process(delta: float) -> void:
	hp_bar.value = Gvars.player_hp

func _activate_rabbit():
	if tutorial_open:
		for r in rabbits:
			r._activate()

func _update_hp():
	hp_bar.max_value = Gvars.player_hp_max
	hp_bar.value = Gvars.player_hp

func _on_recycling_bin() -> void:
	for r in rabbits:
			r._activate()
