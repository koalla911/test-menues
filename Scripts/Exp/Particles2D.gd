extends Particles2D

onready var monitor = $"../monitor"

var time_until_ready = 0

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()


func _process(delta):
	if time_until_ready == 0 and Input.is_action_just_pressed("ui_select"):
		emitting = true
		time_until_ready = lifetime

	var vars = {
		"Emitting": emitting,
		"Ready to fire": "YES" if (time_until_ready == 0 and not emitting) else "no",
	}
	
	if emitting == false and time_until_ready > 0:
		time_until_ready -= delta
		time_until_ready =  max(0, time_until_ready)
		vars["Time Until Ready"] = time_until_ready
	

	var msg = ""
	for key in vars:
		msg += "%s: %s\n" % [key, vars[key]]
		
	monitor.text = msg
