extends Node

var current_score = 0



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


#var columns = 5
#var rows = 2
#
#func make_2d_array():
#	for i in columns:
#		cave.append([1])
#		for j in rows:
#			cave[i].append(2)
#	return cave


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
