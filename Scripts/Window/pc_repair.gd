extends Base_Window
var ref : Base_Window
var healing = false
@export var status : Label

func _on_button_pressed() -> void:
	if ref == null:
		ref = get_parent().get_random_child()
		healing = true
		status.text = "Status: Repairing Something..."

func _process(delta: float) -> void:
	super(delta)
	if ref != null and healing:
		if ref.hp < ref.max_hp:
			ref.hp += 1
			ref._take_damage(0)
		else:
			ref = null
	elif healing:
		healing = false
		status.text = "Status: Idle"
