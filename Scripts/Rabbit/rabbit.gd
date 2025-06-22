extends Node
class_name Rabbit
@export var interval : float = 3
var time_active : int
var direction : int = 1
var active = false
var charmed : Base_Window = null
var charge : int = 0
@export var speed : float = 0.6
# Damage being 1 will not deal any damage, should become 2 when tutorial finishes
@export var damage : int = 2
@export var ai : int = 10
@export var sprite : AnimatedSprite2D
@onready var timer : Timer = $Timer
@onready var smanager : State_Manager = $State_Manager
@onready var hitbox : Area2D = $RBox
var rng = RandomNumberGenerator.new()
signal born

enum STATES {IDLE,LEFT,RIGHT,UP,DOWN,RETURN,REST,LASER}
var state : STATES = STATES.REST:
	set(val):
		state = val
		match state:
			STATES.LASER:
				smanager.current_state.transitioned.emit("LASER_STATE")
			STATES.REST:
				smanager.current_state.transitioned.emit("REST_STATE")
			STATES.IDLE:
				smanager.current_state.transitioned.emit("IDLE_STATE")
			STATES.LEFT:
				smanager.current_state.transitioned.emit("HORIZONTAL_STATE")
			STATES.RIGHT:
				smanager.current_state.transitioned.emit("HORIZONTAL_STATE")
			STATES.UP:
				smanager.current_state.transitioned.emit("VERTICAL_STATE")
			STATES.DOWN:
				smanager.current_state.transitioned.emit("VERTICAL_STATE")
			STATES.RETURN:
				smanager.current_state.transitioned.emit("RETURN_STATE")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox.damage = damage
	timer.wait_time = interval
	timer.timeout.connect(self._tick)
	timer.start()
	_check_action()

func _activate():
	active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _tick():
	time_active += 1
	if time_active == 30:
		interval = 2.5
	if time_active == 90:
		interval = 2
		speed = 0.8
	if time_active == 120:
		interval = 1.7
		speed = 1
	if time_active == 150:
		interval = 1.2
		speed = 1.2
	if time_active == 180:
		damage = 3
		smanager.get_child(1)._change2()
	_check_action()
	
func _check_action():
	var next_state = STATES.IDLE
	var decision_made = false
	hitbox.damage = damage
	var roll = randi_range(0,20)
	
	if not active:
		next_state = STATES.REST
		decision_made = true

	if state == STATES.RETURN and not decision_made:
		next_state = STATES.IDLE
		decision_made = true
		
		
	if roll <= ai and not decision_made:
		if charmed != null:
			var reroll = randi_range(0,20)
			if reroll <= ai:
				decision_made = false
			else:
				decision_made = true
		next_state = STATES.RETURN
		
	if charmed != null and not decision_made:
		decision_made = true
		if charmed.position.x > self.position.x + 20:
			direction = 1
			next_state = STATES.RIGHT
		elif charmed.position.x < self.position.x - 20:
			direction = -1
			next_state = STATES.LEFT
		elif charmed.position.y > self.position.y + 20:
			direction = 1
			next_state = STATES.DOWN
		elif charmed.position.y < self.position.y - 20:
			direction = -1
			next_state = STATES.UP
		else:
			next_state = STATES.RETURN
			
	if roll > ai and not decision_made:
		hitbox.damage = 0
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
	
func _override_state(s):
	if s == "IDLE":
		state = STATES.IDLE
		timer.start()

func _check_hitbox():
	pass

func _process(delta: float) -> void:
	var overlap = hitbox.get_overlapping_areas()
	if state == STATES.IDLE:
		if overlap.is_empty():
			Gvars.player_hp -= damage * 2
		elif hitbox.has_overlapping_areas():
			var windows = hitbox.get_overlapping_areas()
			var shots_fired = false
			for w in windows:
				if w.get_parent() is Base_Window and not shots_fired:
					w.get_parent()._take_damage(damage)
					shots_fired = true
