extends TextureRect

func _ready():
	get_node("Fader/AnimationPlayerIn").play("AnimIn")


func _interpolate(subnoda, noda):
	var GetSubNoda = get_node(noda)
	var GetNoda = get_node(noda).get_node(subnoda)

	GetNoda.interpolate_property(GetSubNoda, "rect_scale", Vector2(1.5, 0.5), Vector2(1.0, 1.0), 0.75, GetNoda.TRANS_ELASTIC, GetNoda.EASE_OUT)
	GetNoda.interpolate_property(GetSubNoda, "modulate", Color(randf(), randf(), randf(), 1.0), Color(1.0, 1.0, 1.0, 1.0), 0.6, GetNoda.TRANS_LINEAR, GetNoda.EASE_IN)
	GetNoda.start()

func _on_ShopButton_pressed():
	_interpolate('Tween', 'ShopButton')


func _on_TomeButton_pressed():
	_interpolate('Tween', 'TomeButton')

func _on_ScrollButton_pressed():
	_interpolate('Tween', 'ScrollButton')

func _on_CovenButton_pressed():
	_interpolate('Tween', 'CovenButton')
	get_node("Fader/AnimationPlayerOut").play("AnimOut")

func _on_CauldronButton_pressed():
	_interpolate('Tween', 'CauldronButton')

func _select_Coven_screen():
	get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1).queue_free()
	get_tree().change_scene("res://Scenes/Coven.tscn")


func _on_TextureButton_toggled(button_pressed):
	match[button_pressed]:
		[true]:
			$CanvasLayer/BurgerButton/Tween.interpolate_property($CanvasLayer/BurgerButton, "modulate", Color(0.0, 1.0, 1.0, 1.0), Color(1.0, 1.0, 1.0, 1.0), 1.0, $CanvasLayer/BurgerButton/Tween.TRANS_LINEAR, $CanvasLayer/BurgerButton/Tween.EASE_IN)
			$CanvasLayer/BurgerButton/Tween.start()
			$Brunches/ModuleOpen.play("ModuleOpen")
		[false]: 
			$CanvasLayer/BurgerButton/Tween.interpolate_property($CanvasLayer/BurgerButton, "modulate", Color(0.0, 0.0, 1.0, 1.0), Color(1.0, 1.0, 1.0, 1.0), 1.0, $CanvasLayer/BurgerButton/Tween.TRANS_LINEAR, $CanvasLayer/BurgerButton/Tween.EASE_IN)
			$CanvasLayer/BurgerButton/Tween.start()
			$Bloodline/ModuleOff.play("Off")


func _on_AnimationPlayerOut_animation_finished(_anim_name):
	_select_Coven_screen()
