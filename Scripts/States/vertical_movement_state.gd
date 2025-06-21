extends State
class_name Vertical_Movement_State

func _enter():
	# No sprite swap
	pass
	
func _exit():
	pass
	
func _tick():
	pass

func update(delta: float):
	if (rabbit.position.y + rabbit.direction * rabbit.speed > 15) and (rabbit.position.y + rabbit.direction * rabbit.speed < 135):
		rabbit.position.y += rabbit.direction * rabbit.speed
