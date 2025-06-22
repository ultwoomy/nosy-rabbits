extends Node2D
class_name Snake_Game


var snake_body = []
var snake_length = 3
var snake_direction = Vector2.RIGHT
var snake_head_position = Vector2(3, 3)
var apple_position = Vector2(7, 7)
var speed = 0.2  # Adjust for desired speed

signal game_over(coins)

@onready var timer = Timer.new()

func _ready():
	add_child(timer)
	timer.wait_time = speed
	timer.timeout.connect(on_timer_timeout)
	timer.start()
  
	get_window().window_input.connect(on_window_input)

func _draw():
	draw_snake()

func on_timer_timeout():
	move_snake()
	queue_redraw()

func move_snake():
	snake_body.append(snake_head_position)
  
	if snake_body.size() >= snake_length:
		snake_body.pop_front()
	
	snake_head_position += snake_direction
  
	snake_head_position.x = wrapf(snake_head_position.x, 0, 16)
	snake_head_position.y = wrapf(snake_head_position.y, 0, 16)
  
	if snake_head_position in snake_body:
		game_over.emit(snake_body.size())
		snake_body = []
		snake_length = 3
		snake_direction = Vector2.RIGHT
		snake_head_position = Vector2(3, 3)
		apple_position = Vector2(7, 7)
		speed = 0.2  # Adjust for desired speed
		return
  
	if snake_head_position == apple_position:
		snake_length += 1
		speed += 0.02
	# Generate new apple position
		while apple_position == snake_head_position or apple_position in snake_body:
			apple_position = Vector2(randi_range(0, 15), randi_range(0, 15))
  
  # Check for game over conditions
  
func on_window_input(event):
	var new_direction = snake_direction
	if event is InputEventKey and event.pressed:
		new_direction = {
			KEY_UP: Vector2.UP,
			KEY_DOWN: Vector2.DOWN,
			KEY_LEFT: Vector2.LEFT,
			KEY_RIGHT: Vector2.RIGHT,
		}.get(event.keycode, snake_direction) # Default to current direction if no valid key
	
	# Prevent reversing direction immediately
	if new_direction != -snake_direction:
		snake_direction = new_direction

func draw_snake():
	var cell_size = 6 # Example cell size
  
	for x in 16:
		for y in 16:
			var rect = Rect2(x * cell_size, y * cell_size, cell_size, cell_size)
			var color = Color.MEDIUM_PURPLE
			if Vector2(x, y) == snake_head_position:
				color = Color.GREEN
			elif Vector2(x, y) in snake_body:
				color = Color.GREEN
			elif Vector2(x, y) == apple_position:
				color = Color.RED
			draw_rect(rect, color)
