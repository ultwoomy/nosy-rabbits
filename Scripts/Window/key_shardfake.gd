extends Base_Window
class_name Key_ShardFake
@onready var text :Label = $Back/Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text.text = str(randi_range(0,9))
	_set_hp(4000)
