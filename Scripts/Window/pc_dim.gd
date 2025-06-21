extends Base_Window
class_name Pc_Dim
@onready var timer : Timer = $Timer
@onready var points : Label = $Back/Points
@onready var dim1 : Label = $"Back/1stDims"
@onready var dim2 : Label = $"Back/2ndDims"
@onready var dim3 : Label = $"Back/3rdDims"
@onready var dim4 : Label = $"Back/4thDims"
@onready var dimcost1 : Label = $"Back/1stDims/Label"
@onready var dimcost2 : Label = $"Back/2ndDims/Label"
@onready var dimcost3 : Label = $"Back/3rdDims/Label"
@onready var dimcost4 : Label = $"Back/4thDims/Label"
@onready var win_button : Button = $"Back/WinButton"
var pts : float = 0
var d1 : float = 0
var d2: float = 0
var d3 : float = 0
var d4 : float = 0
var c1 : float = 0
var c2 : float = 30
var c3 : float = 100
var c4 : float = 10000
var c1s : float = 2
var c2s : float = 3
var c3s : float = 2
var c4s : float = 1

signal dimension_won

func _ready() -> void:
	_set_text()

func _on_timer_timeout() -> void:
	pts += d1
	d1 += d2
	d2 += d3
	d3 += d4
	_set_text()

func to_scientific(x):
	var index = 0
	var ret = ""
	if x < 1000:
		ret = "%.2f" % x
		return ret
	while x > 10:
		x = x / 10
		index += 1
	ret = "%.2f" % x
	ret += "e" + str(index)
	return ret
	
func _set_text():
	points.text = to_scientific(pts)
	dim1.text = " " + to_scientific(d1)
	dim2.text = " " + to_scientific(d2)
	dim3.text = " " + to_scientific(d3)
	dim4.text = " " + to_scientific(d4)
	dimcost1.text = to_scientific(c1)
	dimcost2.text = to_scientific(c2)
	dimcost3.text = to_scientific(c3)
	dimcost4.text = to_scientific(c4)
	win_button.text = "Win Cost: " + to_scientific(2000000)

func _on_b1_pressed() -> void:
	if pts >= c1:
		pts -= c1
		d1 += 1
		c1 *= c1s
		if c1 == 0:
			c1 += 1
		_set_text()

func _on_b2_pressed() -> void:
	if pts >= c2:
		pts -= c2
		d2 += 1
		c2 *= c2s
		_set_text()


func _on_b3_pressed() -> void:
	if pts >= c3:
		pts -= c3
		d3 += 1
		c3 *= c3s
		_set_text()
		

func _on_b4_pressed() -> void:
	if pts >= c4:
		pts -= c4
		d4 += 1
		c4 *= c4s
		_set_text()


func _on_win_button_pressed() -> void:
	if pts >= 2000000:
		dimension_won.emit()
		_exit()
