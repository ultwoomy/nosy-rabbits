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
var rabbits : Array[Rabbit] = []
var tutorial_open = false
var playback : float = 0

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
		if Gvars.phase < 1:
			Gvars.phase = 1
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
	if Gvars.volume != -16:
		audio.volume_db = Gvars.volume
		if not audio.playing and tutorial_open:
			audio.play(playback)
			playback = 0
	else:
		if playback == 0:
			playback = audio.get_playback_position()
		audio.stop()
	hp_bar.value = Gvars.player_hp
	if Gvars.phase == 1 and audio.get_playback_position() >= 170.66:
		audio.play(21.33)
	if Gvars.phase == 2 and audio.get_playback_position() >= 341.33:
		audio.play(192)
	if Gvars.phase == 3 and audio.get_playback_position() >= 521:
		audio.play(426.66)
	if Gvars.phase == 2 and audio.get_playback_position() < 192:
		audio.play(192)
	if Gvars.phase == 3 and audio.get_playback_position() < 341.33:
		audio.play(341.33)

func _activate_rabbit():
	if tutorial_open or rabbits.size() > 1:
		for r in rabbits:
			r._activate()

func _update_hp():
	hp_bar.max_value = Gvars.player_hp_max
	hp_bar.value = Gvars.player_hp

func _on_recycling_bin() -> void:
	if Gvars.volume != -16 and not tutorial_open and not audio.playing:
		audio.volume_db = Gvars.volume
		audio.play()
		Gvars.phase = 1
	for r in rabbits:
			r._activate()
	if timer.is_stopped():
		timer.start()


func _on_timer_timeout() -> void:
	Gvars.score += 1
	if (Gvars.phase == 2) and rabbits.size() == 1:
		var r = load("res://Scenes/rabbit.tscn").instantiate()
		add_child(r)
		r.position = rabbits[0].position
		rabbits.append(r)
		window_manager.rabbits.append(r)
		_activate_rabbit()
	if (Gvars.phase == 3) and rabbits.size() == 2:
		var r = load("res://Scenes/rabbit.tscn").instantiate()
		add_child(r)
		r.position = rabbits[0].position
		rabbits.append(r)
		window_manager.rabbits.append(r)
		_activate_rabbit()
	if (Gvars.phase == 4) and rabbits.size() == 3:
		var r = load("res://Scenes/rabbit.tscn").instantiate()
		add_child(r)
		r.position = rabbits[0].position
		rabbits.append(r)
		window_manager.rabbits.append(r)
		_activate_rabbit()
	

func _hide_arrow():
	helpful_arrow2.hide()


func _on_audio_stream_player_finished() -> void:
	pass


func _on_q_mark_pressed() -> void:
	pass # Replace with function body.
