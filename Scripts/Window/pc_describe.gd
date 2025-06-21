extends Base_Window
var index = 0
@onready var filename : Label = $Back/FileName
@onready var desc : Label = $Back/Desc

func _ready() -> void:
	_set_text()
	_set_hp(3000)

func _on_left_arrow_pressed() -> void:
	index -= 1
	if index < 0:
		index = Gvars.window_pool.size() - 1
	_set_text()


func _on_right_arrow_pressed() -> void:
	index += 1
	if index > Gvars.window_pool.size() - 1:
		index = 0
	_set_text()

func _set_text():
	filename.text = Gvars.window_pool[index].file_name
	desc.text = Gvars.window_pool[index].desc
