extends Node

onready var current_level = $start_menu

func _ready():
	current_level.connect("level_changed", self, "handle_level_changed")

func handle_level_changed(current_level_name: String):
	var next_level 
	var next_level_name: String
	
	match current_level_name:
		"start_screen":
			next_level_name = "level_1"
			print("startscreen match")
		"level_1":
			next_level_name = "level_2"
		"level_2":
			next_level_name = "level_3"
		"level_3":
			next_level_name = "game_complete"
		_:
			return
			
	print("res://levels/" + next_level_name)
	next_level = load("res://levels/" + next_level_name + ".tscn").instance()
	add_child(next_level)
	next_level.connect("level_changed", self, "handle_level_changed")
	current_level.queue_free()
	current_level = next_level