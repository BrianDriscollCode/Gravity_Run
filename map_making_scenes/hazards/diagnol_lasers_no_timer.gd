extends Node2D


var UP = Vector2(0, -1)
const SPEED = 80

func _ready():
	$AnimatedSprite/up_an_down.play()
	
func _on_Area2D_area_entered(area):
	get_tree().call_group("player", "signal_player_death")
