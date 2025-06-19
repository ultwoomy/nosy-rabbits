extends Base_Window
class_name Pc_Snake

@onready var snake_game : Snake_Game = $SnakeGame

func _ready() -> void:
	snake_game.game_over.connect(_spawn_coin)

func _spawn_coin(coins):
	print(coins)
	var new_scene = load("res://Scenes/Window_Scenes/coin.tscn").instantiate()
	new_scene.position = Vector2(0,0)
	new_scene.delete_window.connect(_on_coin_delete)
	new_scene._set_hp(coins)
	add_child(new_scene)
	new_scene._enter()

func _on_coin_delete(ref : Base_Window):
	ref.queue_free()
