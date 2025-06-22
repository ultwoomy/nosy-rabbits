extends Base_Window
class_name Popup_Ad

@export var text : Label
var time_left = 30

func _ready() -> void:
	_set_hp(5000)



func _on_timer_timeout() -> void:
	if get_parent() is Window_Manager:
		time_left -= 1
	text.text = "Ad ends in: " + str(time_left)
	if time_left <= 0:
		_exit()
