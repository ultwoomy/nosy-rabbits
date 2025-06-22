extends Control
@onready var text : Label = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
