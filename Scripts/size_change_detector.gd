extends Node2D
class_name Size_Change
var mold_size:Vector2

signal update_size(new_size)

func _ready()->void:
	$"/root".set_script(load("res://Scripts/rw.gd"))
	var vwindow:Window = get_window()
	vwindow.size_changed.connect(on_size_changed)


func _notification(pwhat:int)->void:
	if pwhat == Node.NOTIFICATION_WM_SIZE_CHANGED: print('_notification(NOTIFICATION_WM_SIZE_CHANGED)')


func on_size_changed()->void:
	var vnewsize:Vector2i = get_window().size
	mold_size = vnewsize
	update_size.emit(mold_size)
