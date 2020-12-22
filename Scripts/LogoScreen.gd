extends Control

func _input(event):
	if(event is InputEventMouseButton):
		_select_language_screen()


func _select_language_screen():
	get_tree().change_scene("res://Scenes/SelectLanguageScreen.tscn")

func _on_AnimationPlayer_animation_finished(anim_name):
	_select_language_screen()
	pass 
