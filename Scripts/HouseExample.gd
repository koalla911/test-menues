extends Control


func _ready():
	$Fader/AnimationPlayerIn.play("AnimIn")
	$AnimationPlayer.play("FireFire")
	#$Sprite2/Sprite/AnimationPlayer.play("SmokeWeed")
	Global.load_score()

func _process(_delta):
	$CanvasLayer/Coins.text = str(Global.current_score)
	Global.save_score()


func _on_TextureButton_pressed():
	Global.current_score += 10


func _on_TextureButton2_pressed():
	SceneTransition._change_scene("res://Scenes/Coven.tscn", 0.4, $Fader/AnimationPlayerOut)

