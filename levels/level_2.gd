extends Node2D

signal level_changed(level_name)

export (String) var level_name = "level"

var time_start
var time_now
var time_elapsed

var time_start_taken = false
	
func _process(delta):
	
	if time_start_taken == false: 
		time_start = OS.get_ticks_msec()
		time_start_taken = true
	time_now = OS.get_ticks_msec()
	time_elapsed = (time_now - time_start)/1000

func next_level():
	
	print("time_start: ", time_start)
	print("time_now: ", time_now)
	get_tree().get_root().get_node("GameInfo").update_level_times(time_elapsed)
	get_tree().get_root().get_node("GameInfo").update_level_completion()
	get_tree().get_root().get_node("GameInfo").print_level_info()
	print("next_level_ran")
	emit_signal("level_changed", level_name)
