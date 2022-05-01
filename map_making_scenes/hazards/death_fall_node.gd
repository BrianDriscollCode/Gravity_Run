extends Node2D


func _ready():
	pass


func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	
	get_tree().call_group("player", "signal_player_death")
