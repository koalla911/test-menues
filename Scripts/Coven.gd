extends TextureRect


onready var storeButtons = $BuildBoard/ScrollContainer/VBoxContainer
onready var environment = $Environment
var save_store_path = 'user://save'


var price = 0
var change = 0
var price_array = 0



func _ready():
	$Fader/AnimationPlayerIn.play("AnimIn")
	$Fader/AnimationPlayerIn.seek(0.0, true)
	Global.load_score()
	
	storeButtons.get_node("StonehangeButton/Label").text = str(Global.store["stonehange"][price])
	storeButtons.get_node("CaveButton/Label").text = str(Global.store["cave"][price])
	storeButtons.get_node("DemonTrapButton/Label").text = str(Global.store["demontrap"][0])
	storeButtons.get_node("DogButton/Label").text = str(Global.store["dog"][price])
	storeButtons.get_node("FairyTreeButton/Label").text = str(Global.store["fairytree"][price])
	storeButtons.get_node("AssistantButton/Label").text = str(Global.store["assistant"][price])
	storeButtons.get_node("GardenButton/Label").text = str(Global.store["garden"][price])
	storeButtons.get_node("HedgeButton/Label").text = str(Global.store["hedge"][price])
	storeButtons.get_node("MushroomButton/Label").text = str(Global.store["mushroom"][price])
	storeButtons.get_node("GraveyardButton/Label").text = str(Global.store["graveyard"][price])
	storeButtons.get_node("PotButton/Label").text = str(Global.store["pot"][price])


func _process(_delta):
	$CanvasLayer/Control/Coins.text = str(Global.current_score)

#########HANDLED CHANGING DEATH SCENE
	if Input.is_key_pressed(KEY_B):
		Global.burning = true
		select_death_screen()
	if Input.is_key_pressed(KEY_D):
		Global.burning = false
		select_death_screen()

func select_death_screen():
	get_node("Fader/AnimationPlayerOut").play("AnimOut")
	yield(get_node("Fader/AnimationPlayerOut"), "animation_finished")
	get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1).queue_free()
	get_tree().change_scene("res://Scenes/WitchDeath.tscn")

func buying_module(price, button):
	Global.load_score()
	if Global.current_score >= price:
		Global.current_score -= price
		Global.save_score()



func set_build(array, buildName, _button):
	$BuildBoard/ModuleClose.play("BuyOff")
	yield($BuildBoard/ModuleClose, "animation_finished")
	environment.get_node(buildName).get_node("Particles2D").emitting = true
	environment.get_node(buildName).get_node("Particles2D").one_shot = true
	if not environment.get_node(buildName).get_node("Particles2D").emitting:
		queue_free()
	
	if array[change] == 1:
		environment.get_node(buildName).visible = true
#		array[change] = 1
		print("true")
	else:
		print("false")


	yield(get_tree().create_timer(0.7),"timeout")
	$BuildBoard/ModuleOpen.play("BuyOn")
	yield($BuildBoard/ModuleOpen, "animation_finished")



func set_price(button, first_price):
	yield(get_tree().create_timer(1.7), "timeout")

	first_price.remove(0)
	first_price.append("Sold")

	storeButtons.get_node(button).get_node("Label").text = str(first_price[price])
	
	if storeButtons.get_node(button).get_node("Label").text == str(first_price[1]):
		#Global.cave.clear()
		storeButtons.get_node(button).disabled = true
	else:
		print("nothing else")




func _on_TextureButton_toggled(button_pressed):
	match[button_pressed]:
		[false]:
			_interpolate('Tween', 'BuildButton', 'CanvasLayer')
			$BuildBoard/ModuleOpen.play("BuyOn")
		[true]: 
			_interpolate('Tween', 'BuildButton', 'CanvasLayer')
			$BuildBoard/ModuleClose.play("BuyOff")


func _on_BurgerButton_toggled(button_pressed):
	match[button_pressed]:
		[false]:
			_interpolate('Tween', 'BurgerButton', 'CanvasLayer')
			$Bloodline/ModuleOn.play("On")
		[true]: 
			_interpolate('Tween', 'BurgerButton', 'CanvasLayer')
			$Bloodline/ModuleOff.play("Off")



func _interpolate(firstnoda, subnoda, noda):
	var GetNoda = get_node(noda).get_node(subnoda)
	var GetFirstNoda = get_node(noda).get_node(subnoda).get_node(firstnoda)

	GetFirstNoda.interpolate_property(GetNoda, "rect_scale", Vector2(1.2, 0.7), Vector2(1.0, 1.0), 0.75, GetFirstNoda.TRANS_ELASTIC, GetFirstNoda.EASE_OUT)
	GetFirstNoda.interpolate_property(GetNoda, "modulate", Color(randf(), randf(), randf(), 1.0), Color(1.0, 1.0, 1.0, 1.0), 0.8, GetFirstNoda.TRANS_LINEAR, GetFirstNoda.EASE_IN)
	GetFirstNoda.start()

func _button_interpolate(thirdnoda, secondnoda, firstnoda, subnoda, noda):
	var FirstNoda = get_node(noda).get_node(subnoda).get_node(firstnoda).get_node(secondnoda)
	var Noda = get_node(noda).get_node(subnoda).get_node(firstnoda).get_node(secondnoda).get_node(thirdnoda)
	Noda.interpolate_property(FirstNoda, "rect_scale", Vector2(1.3, 1.1), Vector2(1.0, 1.0), 0.7, Noda.TRANS_ELASTIC, Noda.EASE_OUT)
	Noda.start()



func _on_CaveButton_pressed():
	_button_interpolate('Tween', 'CaveButton', 'VBoxContainer', 'ScrollContainer', 'BuildBoard')
	buying_module(Global.store["cave"][0], "CaveButton")
	
	set_build(Global.store["cave_upgrades"], "Cave", "CaveButton")
	set_price("CaveButton", Global.store["cave"])


func _on_DemonTrapButton_pressed():
	_button_interpolate('Tween', 'DemonTrapButton', 'VBoxContainer', 'ScrollContainer', 'BuildBoard')
	buying_module(Global.store["demontrap"][0], "DemonTrapButton")
	set_build(Global.store["demontrap_upgrades"], "DemonTrap", "DemonTrapButton")
	set_price("DemonTrapButton", Global.store["demontrap"])

func _on_DogButton_pressed():
	_button_interpolate('Tween', 'DogButton', 'VBoxContainer', 'ScrollContainer', 'BuildBoard')
	buying_module(Global.store["dog"][0], "DogButton")
	set_build(Global.store["dog_upgrades"], "Dog", "DogButton")
	set_price("DogButton", Global.store["dog"])

func _on_FairyTreeButton_pressed():
	_button_interpolate('Tween', 'FairyTreeButton', 'VBoxContainer', 'ScrollContainer', 'BuildBoard')
	buying_module(Global.store["fairytree"][0],"FairyTreeButton")
	set_build(Global.store["fairytree_upgrades"], "FairyTree", "FairyTreeButton")
	set_price("FairyTreeButton", Global.store["fairytree"])

func _on_GardenButton_pressed():
	_button_interpolate('Tween', 'GardenButton', 'VBoxContainer', 'ScrollContainer', 'BuildBoard')
	buying_module(Global.store["garden"][0], "GardenButton")
	set_build(Global.store["garden_upgrades"], "Garden", "GardenButton")
	set_price("GardenButton", Global.store["garden"])

func _on_GraveyardButton_pressed():
	_button_interpolate('Tween', 'GraveyardButton', 'VBoxContainer', 'ScrollContainer', 'BuildBoard')
	buying_module(Global.store["graveyard"][0],  "GraveyardButton")
	set_build(Global.store["graveyard_upgrades"], "Graveyard", "GraveyardButton")
	set_price("GraveyardButton", Global.store["graveyard"])

func _on_HedgeButton_pressed():
	_button_interpolate('Tween', 'HedgeButton', 'VBoxContainer', 'ScrollContainer', 'BuildBoard')
	buying_module(Global.store["hedge"][0], "HedgeButton")
	set_build(Global.store["hedge_upgrades"], "Hedge", "HedgeButton")
	set_price("HedgeButton", Global.store["hedge"])


func _on_MushroomButton_pressed():
	_button_interpolate('Tween', 'MushroomButton', 'VBoxContainer', 'ScrollContainer', 'BuildBoard')
	buying_module(Global.store["mushroom"][0], "MushroomButton")
	set_build(Global.store["mushroom_upgrades"], "Mushrooms", "MushroomButton")
	set_price("MushroomButton", Global.store["mushroom"])

func _on_PotButton_pressed():
	_button_interpolate('Tween', 'PotButton', 'VBoxContainer', 'ScrollContainer', 'BuildBoard')
	buying_module(Global.store["pot"][0], "PotButton")
	set_build(Global.store["pot_upgrades"], "Pot", "PotButton")
	set_price("PotButton", Global.store["pot"])

func _on_StonehangeButton_pressed():
	_button_interpolate('Tween', 'StonehangeButton', 'VBoxContainer', 'ScrollContainer', 'BuildBoard')
	buying_module(Global.store["stonehange"][0], "StonehangeButton")
	set_build(Global.store["pot_upgrades"], "StoneHange", "StonehangeButton")
	set_price("StonehangeButton", Global.store["stonehange"])
	

func _on_AssistantButton_pressed():
	_button_interpolate('Tween', 'AssistantButton', 'VBoxContainer', 'ScrollContainer', 'BuildBoard')
	buying_module(Global.store["assistant"][0], "AssistantButton")
	set_build(Global.store["assistant_upgrades"], "AssistantHouse", "AssistantButton")
	set_price("AssistantButton", Global.store["assistant"])


func _on_TextureRect_pressed():
	SceneTransition._change_scene("res://Scenes/HouseExample.tscn", 0.4, $Fader/AnimationPlayerOut)

