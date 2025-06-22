extends Base_Window
class_name Key_Shard4
@onready var text :Label = $Back/Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text.text = str(Gvars.code[3])
