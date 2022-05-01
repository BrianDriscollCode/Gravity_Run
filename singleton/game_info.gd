extends Node2D

var level_tracker = 0

var level_completion = [ "incomplete", "incomplete", "incomplete"]
var level_times = ["to be added", "to be added", "to be added"] 

func _ready():
	print(level_completion)
	print(level_times)
	
func update_level_times(seconds):
	level_times[level_tracker] = seconds
	
func update_level_completion():
	level_completion[level_tracker] = "complete"
	level_tracker += 1
	#print("update_level_compeletion ran")	
	
func print_level_info():
	pass
	#print(level_completion)
	print(level_times)
	#print("print_level_info ran")
	
func track_level():
	pass
	

