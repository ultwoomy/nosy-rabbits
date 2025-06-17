extends Base_Window
class_name Recycling
var recharge :float = 100
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
	if recharge >= 100 and button_choices[0] != -1:
		create_window.emit(Gvars.window_pool[button_choices[0]].internal_name)
		exceptions.append(Gvars.window_pool[button_choices[0]])
		set_buttons()
		recharge = 0
		prog_bar.show()
		
func _pressed_2():
	if recharge >= 100 and button_choices[1] != -1:
		create_window.emit(Gvars.window_pool[button_choices[1]].internal_name)
		exceptions.append(Gvars.window_pool[button_choices[1]])
		set_buttons()
		recharge = 0
		prog_bar.show()
		
func _pressed_3():
	if recharge >= 100 and button_choices[2] != -1:
		create_window.emit(Gvars.window_pool[button_choices[2]].internal_name)
		exceptions.append(Gvars.window_pool[button_choices[2]])
		set_buttons()
		recharge = 0
		prog_bar.show()
	
	
func _process(delta: float) -> void:
	super(delta)
	if recharge < 100:
		recharge += 0.5
	else:
		recharge = 100
		prog_bar.hide()
	prog_bar.set_value_no_signal(recharge)
		
func roll_window():
	Gvars.window_pool.shuffle()
	var roll = 0
	if exceptions.size() >= Gvars.window_pool.size():
		return -1
	while exceptions.has(Gvars.window_pool[roll].internal_name) or temp_exceptions.has(Gvars.window_pool[roll].internal_name):
		roll += 1
	return roll
	
func set_buttons():
	var x = roll_window()
	if x == -1:
		choice1.get_child(0).text = "unselectable.png"
	else:
		choice1.get_child(0).text = Gvars.window_pool[x].file_name
	button_choices[0] = x
	temp_exceptions.append(Gvars.window_pool[x].internal_name)
	x = roll_window()
	if x == -1:
		choice2.get_child(0).text = "unselectable.png"
	else:
		choice2.get_child(0).text = Gvars.window_pool[x].file_name
	button_choices[1] = x
	temp_exceptions.append(Gvars.window_pool[x].internal_name)
	x = roll_window()
	if x == -1:
		choice3.get_child(0).text = "unselectable.png"
	else:
		choice3.get_child(0).text = Gvars.window_pool[x].file_name
	button_choices[2] = x
	temp_exceptions.clear()
