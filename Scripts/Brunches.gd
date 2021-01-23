extends Node2D

#signal icon_spotted


var drag_start = Vector2.ZERO
var dragging = false

var swipe_start = null
var minimum_drag = 100

var witch_porttrait = "res://Sprites/Family Tree"

func _ready():
	wasted()
	yield(get_node("Fader/AnimationPlayerIn"), "animation_finished")
	get_node("Fader/AnimationPlayerIn").seek(0.5, true)


func wasted():
	$Fader/AnimationPlayerIn.play("AnimIn")
	if Global.wasted == true:
		yield(get_node("Fader/AnimationPlayerIn"), "animation_finished")
		$ParallaxBackground/ParallaxLayer.motion_mirroring = $ParallaxBackground/ParallaxLayer/Sprite.texture.get_size().rotated($ParallaxBackground/ParallaxLayer/Sprite.global_rotation)
		$ParallaxBackground/ParallaxLayer/Tween.interpolate_property($ParallaxBackground/ParallaxLayer, "position", Vector2(0.0, 0.0), Vector2(0.0, -2000.0), 1.5, $ParallaxBackground/ParallaxLayer/Tween.TRANS_EXPO, $ParallaxBackground/ParallaxLayer/Tween.EASE_IN_OUT)
		$ParallaxBackground/ParallaxLayer/Tween.start()
		#yield($ParallaxBackground/ParallaxLayer/Tween, "tween_completed")
		$ParallaxBackground/ParallaxLayer/WitchIcon/FrameBack/Sprite.set_texture(load(Global.witch_icons[0]))


#
#func _on_Area2D_body_entered(_body):
#	emit_signal("icon_spotted")

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			swipe_start = event.get_position()
		else:
			set_swipe(event.get_position())


func set_swipe(swipe_end):
	if swipe_start == null:
		return
	var swipe = swipe_end - swipe_start
	if abs(swipe.y) > minimum_drag:
		if swipe.y > 0:
			$ParallaxBackground/ParallaxLayer.motion_mirroring = $ParallaxBackground/ParallaxLayer/Sprite.texture.get_size().rotated($ParallaxBackground/ParallaxLayer/Sprite.global_rotation)
			$ParallaxBackground/ParallaxLayer/Tween.interpolate_property($ParallaxBackground/ParallaxLayer, "position", Vector2(0.0, 0.0), Vector2(0.0, 2000.0), 0.7, $ParallaxBackground/ParallaxLayer/Tween.TRANS_LINEAR, $ParallaxBackground/ParallaxLayer/Tween.EASE_IN)
			$ParallaxBackground/ParallaxLayer/Tween.start()
		else:
			$ParallaxBackground/ParallaxLayer.motion_mirroring = $ParallaxBackground/ParallaxLayer/Sprite.texture.get_size().rotated($ParallaxBackground/ParallaxLayer/Sprite.global_rotation)
			$ParallaxBackground/ParallaxLayer/Tween.interpolate_property($ParallaxBackground/ParallaxLayer, "position", Vector2(0.0, 0.0), Vector2(0.0, -2000.0), 0.7, $ParallaxBackground/ParallaxLayer/Tween.TRANS_LINEAR, $ParallaxBackground/ParallaxLayer/Tween.EASE_IN)
			$ParallaxBackground/ParallaxLayer/Tween.start()


####### NON-SWIPED BRUNCH SCROLL 
#func _unhandled_input(event):
#	if event is InputEventMouseButton:
#		if event.is_action_pressed("click"):
##			dragging = true
##		else:
##			dragging = false
##	elif event is InputEventMouseMotion:
##		if dragging:
#			$ParallaxBackground/ParallaxLayer.motion_mirroring = $ParallaxBackground/ParallaxLayer/Sprite.texture.get_size().rotated($ParallaxBackground/ParallaxLayer/Sprite.global_rotation)
##			var scroll = Vector2(0, -15)
##			$ParallaxBackground.scroll_offset += scroll
#
#			$ParallaxBackground/ParallaxLayer/Tween.interpolate_property($ParallaxBackground/ParallaxLayer, "position", Vector2(0.0, 0.0), Vector2(0.0, -2000.0), 2.0, $ParallaxBackground/ParallaxLayer/Tween.TRANS_LINEAR, $ParallaxBackground/ParallaxLayer/Tween.EASE_IN)
#			$ParallaxBackground/ParallaxLayer/Tween.start()



func _on_TextureButton_toggled(button_pressed):
	match[button_pressed]:
		[true]:
			$CanvasLayer/BurgerButton/Tween.interpolate_property($CanvasLayer/BurgerButton, "modulate", Color(0.0, 1.0, 1.0, 1.0), Color(1.0, 1.0, 1.0, 1.0), 1.0, $CanvasLayer/BurgerButton/Tween.TRANS_LINEAR, $CanvasLayer/BurgerButton/Tween.EASE_IN)
			$CanvasLayer/BurgerButton/Tween.start()
			$MainMenu/ModuleOn.play("MenuOn")
		[false]: 
			$CanvasLayer/BurgerButton/Tween.interpolate_property($CanvasLayer/BurgerButton, "modulate", Color(0.0, 0.0, 1.0, 1.0), Color(1.0, 1.0, 1.0, 1.0), 1.0, $CanvasLayer/BurgerButton/Tween.TRANS_LINEAR, $CanvasLayer/BurgerButton/Tween.EASE_IN)
			$CanvasLayer/BurgerButton/Tween.start()
			$MainMenu/ModuleOff.play("MenuOff")

func _interpolate(subnoda, noda):
	var GetSubNoda = get_node("MainMenu").get_node(noda)
	var GetNoda = GetSubNoda.get_node(subnoda)

	GetNoda.interpolate_property(GetSubNoda, "rect_scale", Vector2(1.5, 0.5), Vector2(1.0, 1.0), 0.75, GetNoda.TRANS_ELASTIC, GetNoda.EASE_OUT)
	GetNoda.interpolate_property(GetSubNoda, "modulate", Color(randf(), randf(), randf(), 1.0), Color(1.0, 1.0, 1.0, 1.0), 0.6, GetNoda.TRANS_LINEAR, GetNoda.EASE_IN)
	GetNoda.start()

func _on_ShopButton_pressed():
	_interpolate('Tween', 'ShopButton')
	yield(get_node("MainMenu/ShopButton/Tween"), "tween_completed")
	Global.select_next_screen("res://Scenes/Shop.tscn")


func _on_CovenButton_pressed():
	_interpolate('Tween', 'CovenButton')
	yield(get_node("MainMenu/CovenButton/Tween"), "tween_completed")
	Global.select_next_screen("res://Scenes/Coven.tscn")

func _on_CauldronButton_pressed():
	_interpolate('Tween', 'CauldronButton')
	yield(get_node("MainMenu/CauldronButton/Tween"), "tween_completed")
	Global.select_next_screen("res://Scenes/HouseExample.tscn")





func _on_Sprite_tree_entered():
	$ParallaxBackground/ParallaxLayer/WitchIcon/FrameBack/Sprite.set_texture(load(Global.witch_icons[0]))
	#Global.witch_icons.remove(0)
	#Global.witch_icons.append("res://Sprites/Family Tree/witch_porttrait2.png")
	print("entered")


func _on_Sprite_tree_exiting():
	print("exit")


func _on_Sprite_tree_exited():
	print("????")
