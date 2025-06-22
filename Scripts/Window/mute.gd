extends Base_Window
class_name Mute
@onready var check : CheckBox = $CheckBox

func _ready() -> void:
	_set_hp(400)


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Gvars.volume = -16
	else:
		Gvars.volume = Gvars.saved_volume
