extends State
class_name Vertical_Movement_State

func _enter():
	# No sprite swap
	rabbit.sprite.play("Moving")
	
func _exit():
	pass
	
func _tick():
	pass

func update(delta: float):
	if rabbit.sprite.frame == 1:
		if (rabbit.position.y + rabbit.direction * rabbit.speed > 15) and (rabbit.position.y + rabbit.direction * rabbit.speed < 115):
			rabbit.position.y += rabbit.direction * rabbit.speed
