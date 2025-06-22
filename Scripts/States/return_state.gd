extends State
class_name Return_State

func _enter():
	rabbit.sprite.play("Return")
	
func _exit():
	pass

func _tick():
	pass
	
func update(delta: float):
	if rabbit.sprite.frame == 3:
		rabbit._override_state("IDLE")
