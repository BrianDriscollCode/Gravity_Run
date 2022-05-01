extends Node2D

var number = 0
onready var animation = $AnimatedSprite
onready var light = $Light2D

var is_player_saved = false

func _physics_process(_delta):
	if animation.get_frame() == 6:
		animation.set_animation("up")
		is_player_saved = true
		
	if is_player_saved == true:
		light.set_enabled(true)
		
func _ready():
	pass


func _on_Area2D_area_entered(_area):
	
	if is_player_saved == false:
		animation.set_animation("change")
		animation._set_playing(true)
		
	get_tree().call_group("player", "set_ressurection_location")

	
	
