extends Base_Window
class_name Png_Dvdsaver
var x_direction = 1
var y_direction = -1
var x_bound_left = 2
var x_bound_right = 318
var y_bound_down = 153
var y_bound_up = 5

func _ready() -> void:
	_set_hp(2000)
	draggable = false
	
func _process(delta: float) -> void:
	if self.position.x - 50 + x_direction < x_bound_left:
		x_direction = 1
	if self.position.x + 24 + x_direction > x_bound_right:
		x_direction = -1
	if self.position.y + 63 + y_direction > y_bound_down:
		y_direction = -1
	if self.position.y - 6 + y_direction < y_bound_up:
		y_direction = 1
	var change = Vector2(x_direction,y_direction)
	self.position += change
	super(delta)
	
