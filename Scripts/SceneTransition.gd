extends CanvasModulate

signal scene_changed()


func _change_scene(path, delay, animation):
	yield(get_tree().create_timer(delay), "timeout")
	animation.play("AnimOut")
	yield(animation, "animation_finished")
	get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1).queue_free()
	assert(get_tree().change_scene(path) == OK)
	emit_signal("scene_changed")
