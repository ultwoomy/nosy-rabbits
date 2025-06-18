extends Base_Window
class_name Virus_Idiot
@export var sprite : AnimatedSprite2D
@export var timer : Timer

func _ready() -> void:
	deletable = false
	minimizable = false
	_set_hp(999)

func _on_timer_timeout() -> void:
	if sprite.frame == 0:
		sprite.frame = 1
	else:
		sprite.frame = 0
