extends Node2D

var drag_start = Vector2.ZERO
var dragging = false

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("click"):
			dragging = true
			print("click")
		else:
			dragging = false
	elif event is InputEventMouseMotion:
		if dragging:
			$ParallaxBackground/ParallaxLayer.motion_mirroring = $ParallaxBackground/ParallaxLayer/Sprite.texture.get_size().rotated($ParallaxBackground/ParallaxLayer/Sprite.global_rotation)
			var scroll = Vector2(0, -15)
			$ParallaxBackground.scroll_offset += scroll
			print("scroll")
#			var drag_end = get_global_mouse_position()
#			var dir = drag_start - drag_end
#			apply_impulse(scroll_offset, dir * 5)
#			print("false")
