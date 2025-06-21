extends Base_Window
class_name Key_Lock
var code = [0,0,0,0]
@onready var num1 : Label = $Back/Number1/Num
@onready var num2 : Label = $Back/Number2/Num
@onready var num3 : Label = $Back/Number3/Num
@onready var num4 : Label = $Back/Number4/Num

func _ready() -> void:
	_set_hp(500)
	
func _set_text():
	num1.text = str(code[0])
	num2.text = str(code[1])
	num3.text = str(code[2])
	num4.text = str(code[3])
	
func _increment_count(id,x):
	code[id] += x
	if code[id] > 9:
		code[id] = 0
	if code[id] < 0:
		code[id] = 9
	_set_text()

func _on_up_arrow_pressed1() -> void:
	_increment_count(0,1)

func _on_down_arrow_pressed1() -> void:
	_increment_count(0,-1)


func _on_up_arrow_pressed2() -> void:
	_increment_count(1,1)


func _on_down_arrow_pressed2() -> void:
	_increment_count(1,-1)


func _on_up_arrow_pressed3() -> void:
	_increment_count(2,1)


func _on_down_arrow_pressed3() -> void:
	_increment_count(2,-1)


func _on_up_arrow_pressed4() -> void:
	_increment_count(3,1)


func _on_down_arrow_pressed4() -> void:
	_increment_count(3,-1)


func _on_enter_code_pressed() -> void:
	var wrong = true
	for i in code:
		if i == Gvars.code[i]:
			wrong = false
	if not wrong:
		#Winning sequence
		pass
