extends State
class_name Idle_State
var p = 1

func _enter():
	if p == 1:
		rabbit.sprite.play("Idle")
	else:
		rabbit.sprite.play("Idle2")
	
func _exit():
	pass

func _tick():
	pass
	
func update(delta: float):
	pass

func _change2():
	p = 2
