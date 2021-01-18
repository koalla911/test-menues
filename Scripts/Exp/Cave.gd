extends AnimatedSprite

var save_store_path = 'user://save_builds'

func _ready():
	#load_builds()
	play("Invisible")
#
#func save_builds():
#	var file = File.new()
#	file.open(save_store_path, file.WRITE_READ)
#	file.store_string(animation)
#	file.close()
#
#func load_builds():
#	var file = File.new()
#	if not file.file_exists(save_store_path):
#		return false
#	file.open(save_store_path, file.READ)
#	animation = file.get_path()
#	file.close()
#	return animation


func _on_CaveButton_pressed():
	play("Visible")
	#save_builds()
