extends Node2D


func _ready():
	get_node("Fader/AnimationPlayerIn").play("AnimIn")

func _on_EnglishLanguageButton_pressed():
	get_node("Fader/AnimationPlayerOut").play("AnimOut")

func _on_RussianLanguageButton_pressed():
	get_node("Fader/AnimationPlayerOut").play("AnimOut")

func _select_brunches_screen():
	get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1).queue_free()
	get_tree().change_scene("res://Scenes/Brunches.tscn")

func _on_AnimationPlayerOut_animation_finished(_anim_name):
	_select_brunches_screen()
