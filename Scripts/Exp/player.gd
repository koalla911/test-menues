extends KinematicBody2D

var acc = Vector2()
var speed = 200
var screen_size = Vector2()

var countdown = 10

# ------------ Player sprite variables
# Please NOTE: all player sprites in the store must be present in this array in their respective order
var textures = [
			'res://icon.png',
			'res://assets/player2.svg',
			'res://assets/player3.svg',
]


func _ready():
# ---------- Load the store
	Global.load_store()
# ------- Choose the selected sprite
	$Sprite.texture = load(textures[Global.store.selected])




	









