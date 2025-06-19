extends Base_Window
class_name Virus_Idiot
@export var sprite : AnimatedSprite2D
@export var timer : Timer
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	deletable = false
	minimizable = false
	_set_hp(999)

func _on_timer_timeout() -> void:
	if sprite.frame == 0:
		sprite.frame = 1
	else:
		sprite.frame = 0

func _on_delete_pressed() -> void:
	var pos = Vector2(randi_range(10,300),randi_range(10,130))
	self.position = pos
	super()
	
func _on_minimize_pressed() -> void:
	var pos = Vector2(randi_range(10,300),randi_range(10,130))
	self.position = pos
	super()
