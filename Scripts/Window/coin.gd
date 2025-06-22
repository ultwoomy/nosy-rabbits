extends Base_Window
class_name Coin

var coin = 0
@export var text : Label

# Called when the node enters the scene tree for the first time.
func _set_hp(coins):
	max_hp = (coins - 2) * 300
	hp = (coins - 2) * 300
	coin = coins

func _enter():
	super()
	text.text = "Score: " + str(coin - 2)
