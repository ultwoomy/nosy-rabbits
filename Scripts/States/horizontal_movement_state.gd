extends State
class_name Horizontal_Movement_State

func _enter():
	# Swap sprite to leftward or rightward facing
	rabbit.sprite.play("Moving")
	if (rabbit.direction < 0):
		rabbit.scale.x = -abs(rabbit.scale.x)
	else:
		rabbit.scale.x = abs(rabbit.scale.x)
	
func _exit():
	pass
	
func _tick():
	pass

func update(delta: float):
	if rabbit.sprite.frame == 1:
		if (rabbit.position.x + rabbit.direction * rabbit.speed > 5) and (rabbit.position.x + rabbit.direction * rabbit.speed < 315):
			rabbit.position.x += rabbit.direction * rabbit.speed
