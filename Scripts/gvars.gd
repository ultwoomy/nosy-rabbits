extends Node
@export var player_hp = 300
@export var player_hp_max = 300
@export var player_regen = 1

var window_pool : Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var temp = File_Extension.new()
	temp.file_name = "tutorial.txt"
	temp.internal_name = "tutorial"
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "catscradle.png"
	temp.internal_name = "png_cat"
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "treat.png"
	temp.internal_name = "png_carrot"
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "nv2iu34589f.exe"
	temp.internal_name = "virus_idiot"
	window_pool.append(temp)
	
	temp = File_Extension.new()
	temp.file_name = "iruntoday.mp4"
	temp.internal_name = "popup_ad"
	window_pool.append(temp)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_hp < player_hp_max:
		player_hp += player_regen
	if player_hp <= 0:
		pass
		#Loss sequence here
