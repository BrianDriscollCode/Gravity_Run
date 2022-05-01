extends Node2D

#changes level when portal entered
func _on_Area2D_area_entered(_area):
	get_tree().call_group("levels", "next_level")
