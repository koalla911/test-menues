extends TextureRect

func _ready():
	$ShopButton.modulate = Color(0.0, 0.0, 0.0, 1.0)

func _interpolate(subnoda, noda):
	var GetSubNoda = get_node(noda)
	var GetNoda = get_node(noda).get_node(subnoda)

	GetNoda.interpolate_property(GetSubNoda, "rect_scale", Vector2(1.5, 0.5), Vector2(1.0, 1.0), 0.75, GetNoda.TRANS_ELASTIC, GetNoda.EASE_OUT)
	GetNoda.interpolate_property(GetSubNoda, "modulate", Color(randf(), randf(), randf(), 1.0), Color(1.0, 1.0, 1.0, 1.0), 0.6, GetNoda.TRANS_LINEAR, GetNoda.EASE_IN)
	GetNoda.start()


func _on_CovenButton_pressed():
	_interpolate('Tween', 'CovenButton')
	yield(get_node("Fader/AnimationPlayerOut"), "animation_finished")
	_select_next_screen("res://Scenes/Coven.tscn")

func _on_CauldronButton_pressed():
	_interpolate('Tween', 'CauldronButton')
	yield(get_node("Fader/AnimationPlayerOut"), "animation_finished")
	_select_next_screen("res://Scenes/HouseExample.tscn")

func _select_next_screen(scene):
	get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1).queue_free()
	get_tree().change_scene(scene)
