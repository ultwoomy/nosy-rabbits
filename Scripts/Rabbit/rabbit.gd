extends Node
class_name Rabbit
@export var interval : float
var time_active : int
var direction : int = 1
@export var speed : float
@export var ai : int = 10
@onready var sprite : AnimatedSprite2D = $Rabbit_Sprite
@onready var timer : Timer = $Timer
@onready var smanager : State_Manager = $State_Manager
var rng = RandomNumberGenerator.new()

enum STATES {IDLE,LEFT,RIGHT,UP,DOWN,NIBBLE}
var state : STATES = STATES.IDLE:
	set(val):
		state = val
		match state:
			STATES.IDLE:
				smanager.current_state.transitioned.emit("IDLE_STATE")
				print("i")
			STATES.LEFT:
				smanager.current_state.transitioned.emit("HORIZONTAL_STATE")
				print("l")
			STATES.RIGHT:
				smanager.current_state.transitioned.emit("HORIZONTAL_STATE")
				print("r")
			STATES.UP:
				smanager.current_state.transitioned.emit("VERTICAL_STATE")
				print("u")
			STATES.DOWN:
				smanager.current_state.transitioned.emit("VERTICAL_STATE")
				print("d")
			STATES.NIBBLE:
				smanager.current_state.transitioned.emit("NIBBLE")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = interval
	timer.timeout.connect(self._tick)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _tick():
	time_active += 1
	_check_action()
	
func _check_action():
	var next_state = STATES.IDLE
	var roll = randi_range(0,20)
	if roll <= ai:
		var action = randi_range(1,4)
		if (action == 1):
			direction = -1
			next_state = STATES.LEFT
		elif(action == 2):
			direction = 1
			next_state = STATES.RIGHT
		elif (action == 3):
			direction = -1
			next_state = STATES.UP
		elif(action == 4):
			direction = 1
			next_state = STATES.DOWN
			
	state = next_state
	
func _check_hitbox():
	pass
