extends Base_Window
class_name Recycling
var recharge :float = 100
var copy_windows : Array = Gvars.window_pool.duplicate()
var exceptions : Array = []
var temp_exceptions : Array = []
var button_choices : Array = [-1,-1,-1]

@onready var choice1 : TextureButton = $Control/Choice1
@onready var choice2 : TextureButton = $Control/Choice2
@onready var choice3 : TextureButton = $Control/Choice3
@onready var prog_bar : ProgressBar = $ProgressBar

signal create_window(id)

func _ready() -> void:
	prog_bar.hide()
	set_buttons()
	
func _pressed_1():
	if recharge >= 100 and button_choices[0] != null:
		create_window.emit(button_choices[0].internal_name)
		exceptions.append(button_choices[0].internal_name)
		button_choices[0].seen = true
		set_buttons()
		recharge = 0
		_check_phase()
		
func _pressed_2():
	if recharge >= 100 and button_choices[1] != null:
		create_window.emit(button_choices[1].internal_name)
		exceptions.append(button_choices[1].internal_name)
		button_choices[1].seen = true
		set_buttons()
		recharge = 0
		_check_phase()
		
func _pressed_3():
	if recharge >= 100 and button_choices[2] != null:
		create_window.emit(button_choices[2].internal_name)
		exceptions.append(button_choices[2].internal_name)
		button_choices[2].seen = true
		set_buttons()
		recharge = 0
		_check_phase()
	
func _check_phase():
	if Gvars.phase == 1 and exceptions.size() > Gvars.window_pool.size()/3:
		Gvars.phase += 1
	if Gvars.phase == 2 and exceptions.size() > 2 * Gvars.window_pool.size()/3:
		Gvars.phase += 1
	
func _process(delta: float) -> void:
	super(delta)
	if recharge < 100:
		recharge += 0.1
		prog_bar.show()
	else:
		recharge = 100
		prog_bar.hide()
	prog_bar.set_value_no_signal(recharge)
		
func roll_window():
	copy_windows.shuffle()
	var roll = 0
	print(str(Gvars.window_pool.size() - exceptions.size() - temp_exceptions.size()))
	if exceptions.size() + temp_exceptions.size() >= copy_windows.size():
		return null
	while exceptions.has(copy_windows[roll].internal_name) or temp_exceptions.has(copy_windows[roll].internal_name) or (copy_windows[roll].internal_name == "key_shard4" and Gvars.window_pool.size() - exceptions.size() - temp_exceptions.size() > 3):
		roll += 1
	return copy_windows[roll]
	
func set_buttons():
	var x = roll_window()
	if not x:
		choice1.get_child(0).text = "unselectable.png"
		button_choices[0] = null
	else:
		choice1.get_child(0).text = x.file_name
		temp_exceptions.append(x.internal_name)
		button_choices[0] = x
	x = roll_window()
	if not x:
		choice2.get_child(0).text = "unselectable.png"
		button_choices[1] = null
	else:
		choice2.get_child(0).text = x.file_name
		temp_exceptions.append(x.internal_name)
		button_choices[1] = x
	x = roll_window()
	if not x:
		choice3.get_child(0).text = "unselectable.png"
		button_choices[2] = null
	else:
		choice3.get_child(0).text = x.file_name
		button_choices[2] = x
	temp_exceptions.clear()
