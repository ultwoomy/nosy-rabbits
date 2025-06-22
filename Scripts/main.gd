extends Node2D
var tutorial_hp = 2000
@onready var window_manager : Window_Manager = $Window_Manager
@onready var notepad : TextureButton = $NotepadIcon
@onready var hp_bar : TextureProgressBar = $HpBar
@onready var power : Button = $Power
@onready var timer : Timer = $Timer
@onready var helpful_arrow1 : Sprite2D = $HelpfulArrow1
@onready var helpful_arrow2 : Sprite2D = $HelpfulArrow2
@onready var audio : AudioStreamPlayer = $AudioStreamPlayer
var phase = 0
var rabbits : Array[Rabbit] = []
var tutorial_open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(Gvars.code)
	rabbits.append(get_child(2))
	window_manager.tutorial_closed.connect(check_tutorial_hp)
	hp_bar.max_value = Gvars.player_hp_max
	power.show_behind_parent = true
	window_manager.clicked_window.connect(_hide_arrow)

func check_tutorial_hp(hp):
	tutorial_hp = hp
	
func _on_notepad_icon_pressed() -> void:
	if Gvars.volume != -16 and not tutorial_open and not audio.playing:
		audio.volume_db = Gvars.volume
		audio.play()
		phase = 1
	if not tutorial_open and tutorial_hp > 0:
		tutorial_open = true
		window_manager._add_window("tutorial")
		notepad.hide()
		helpful_arrow1.hide()
		if timer.is_stopped():
			timer.start()
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
	if Gvars.volume != -16 and not tutorial_open and not audio.playing:
		audio.volume_db = Gvars.volume
		audio.play()
		phase = 1
	for r in rabbits:
			r._activate()
	if timer.is_stopped():
		timer.start()


func _on_timer_timeout() -> void:
	Gvars.score += 1
	if (Gvars.score == 120) or Gvars.score == 300:
		var r = load("res://Scenes/rabbit.tscn").instantiate()
		add_child(r)
		r.position = rabbits[0].position
		rabbits.append(r)
		_activate_rabbit()

func _hide_arrow():
	helpful_arrow2.hide()
