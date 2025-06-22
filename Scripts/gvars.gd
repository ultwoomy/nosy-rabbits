extends Node
@export var player_hp = 1800
@export var player_hp_max = 1800
@export var player_regen = 1
@export var volume : float = 0
@export var saved_volume : float = 0
var phase = 0
var code = [0,0,0,0]
var time_lived : int = 0
var window_pool : Array = []
var score = 0
var win_status = "na"

func _reset_hp():
	player_hp = 1800
	player_hp_max = 1800
	player_regen = 1
	score = 0
	phase = 0
	win_status = "na"
	var i = 0
	while i < 4:
		code[i] = randi_range(0,9)
		i += 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	saved_volume = volume
	if not window_pool.is_empty():
		window_pool.clear()
	_reset_hp()
	var temp = File_Extension.new()
	temp.file_name = "catscradle.png"
	temp.internal_name = "png_cat"
	temp.desc = "Kitty Located"
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "treat.png"
	temp.internal_name = "png_carrot"
	temp.desc = "Delicious carrot. Rabbits love it, and will move towards it whenever they get the opportunity."
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "nv2iu34589f.exe"
	temp.internal_name = "virus_idiot"
	temp.desc = "Nostalgic virus. Can be used to block the rabbits and is very tanky, but teleports instead of moving."
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "icleantoday.mp4"
	temp.internal_name = "popup_ad"
	temp.desc = "How did the previous owner download an ad? Very tanky, but deletes itself in 30 seconds."
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "snake.exe"
	temp.internal_name = "pc_snake"
	temp.desc = "Snake game that came with the computer. Get more points to create a coin with more health based on amount of points gained."
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "slant.png"
	temp.internal_name = "png_groblin"
	temp.desc = "It's kinda sideways"
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "pants.png"
	temp.internal_name = "png_pants"
	temp.desc = "This window is pants."
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "pcrepair.exe"
	temp.internal_name = "pc_repair"
	temp.desc = "A program that repairs other windows. The more damaged the window, the longer the repair will take. It picks randomly."
	window_pool.append(temp)

	temp = File_Extension.new()
	temp.file_name = "123dimensions.exe"
	temp.internal_name = "pc_dim"
	temp.desc = "A short numbers game. Creates a window of such immense strength on victory, that it doubles this game's filesize."
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "weather.exe"
	temp.internal_name = "pc_weather"
	temp.desc = "Gave the forecast. At some point in development that is."
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "coinjoinedwindo.png"
	temp.internal_name = "png_double"
	temp.desc = "Double the window, double the... window."
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "thedescriber.png"
	temp.internal_name = "pc_describe"
	temp.desc = "Descibes windows. Hey that's me!"
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "keyshard1.txt"
	temp.internal_name = "key_shard1"
	temp.desc = "The first number to the passcode that opens up when you hit power."
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "keyshard2.txt"
	temp.internal_name = "key_shard2"
	temp.desc = "The second number to the passcode that opens up when you hit power."
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "keyshard3.txt"
	temp.internal_name = "key_shard3"
	temp.desc = "The third number to the passcode that opens up when you hit power."
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "keyshard4.txt"
	temp.internal_name = "key_shard4"
	temp.desc = "The fourth number to the passcode that opens up when you hit power. Only shows up when most other windows are restored."
	window_pool.append(temp)

	temp = File_Extension.new()
	temp.file_name = "keyshardFAKE.txt"
	temp.internal_name = "key_shardfake"
	temp.desc = "A deceptive keyshard planted to make the player forget the code. Much tankier than the others."
	window_pool.append(temp)

	temp = File_Extension.new()
	temp.file_name = "dvd_saver.png"
	temp.internal_name = "png_dvdsaver"
	temp.desc = "Bounces around the screen being of no help to anyone."
	window_pool.append(temp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_hp < player_hp_max:
		player_hp += player_regen
	if player_hp <= 0:
		win_status = "loss"
		get_tree().change_scene_to_file("res://Scenes/Loss.tscn")
