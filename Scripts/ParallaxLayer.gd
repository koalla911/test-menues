extends RigidBody2D

var dragging 
var drag_start = Vector2.ZERO

func _input(event):
	if event.is_action_pressed("click") and not dragging:
		dragging = true
		drag_start = get_global_mouse_position()
		print("true")
	if event.is_action_pressed("click") and dragging:
		dragging = false
		var drag_end = get_global_mouse_position()
		var dir = drag_start - drag_end
		apply_impulse(Vector2.ZERO, dir * 5)
		print("false")
