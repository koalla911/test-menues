extends Node2D

func _ready():
	get_node("Fader/AnimationPlayerIn").play("AnimIn")


func _input(event):
	if(event is InputEventMouseButton):
		_select_language_screen()


func _on_AnimationPlayerIn_animation_finished(_anim_name):
	yield(get_tree().create_timer(1), "timeout")
	get_node("Fader/AnimationPlayerOut").play("AnimOut")


func _on_AnimationPlayerOut_animation_finished(_anim_name):
	_select_language_screen()


func _select_language_screen():
	get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1).queue_free()
	get_tree().change_scene("res://Scenes/SelectLanguageScreen.tscn")
