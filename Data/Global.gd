extends Node

var current_score = 0

var burning
var wasted

var store = { 
		"dog" : [500, 1000, 1500], "dog_upgrades" : [1, 2],
		"garden" : [700, 1500, 3000], "garden_upgrades" : [1, 2],
		"stonehange" : [400, 800, 1200], "stonehange_upgrades" : [1, 2],
		'fairytree' : [400, 800, 1200], "fairytree_upgrades" : [1, 2],
		'graveyard' : [500, 1000, 1500], "graveyard_upgrades" : [1, 2],
		'hedge' : [500, 1000, 1500], "hedge_upgrades" : [1, 2],
		'assistant' : [500, 1000, 1500], "assistant_upgrades" : [1, 2],
		'pot' : [500, 1000, 1500], "pot_upgrades" : [1, 2],
		'demontrap' : [700, 1500, 2500], "demontrap_upgrades" : [1, 2],
		'mushroom' : [700, 1500, 2500], "mushroom_upgrades" : [1, 2],
		"cave" : [400, 800, 1200], "cave_upgrades" : [1, 2]
	}

var witch_icons = [
		"res://Sprites/Family Tree/witch_porttrait1.png",
		"res://Sprites/Family Tree/witch_porttrait2.png",
		"res://Sprites/Family Tree/witch_porttrait1.png",
		"res://Sprites/Family Tree/witch_porttrait2.png",
	]


func select_next_screen(scene):
	get_node("Fader/AnimationPlayerOut").play("AnimOut")
	yield(get_node("Fader/AnimationPlayerOut"), "animation_finished")
	get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1).queue_free()
	get_tree().change_scene(scene)

var save_store_path = 'user://save'

func save_score():
	var file = File.new()
	file.open(save_store_path, file.WRITE_READ)
	file.store_16(current_score)
	file.close()

func load_score():
	var file = File.new()
	if not file.file_exists(save_store_path):
		return false
	file.open(save_store_path, file.READ)
	current_score = file.get_16()
	file.close()
	return current_score
