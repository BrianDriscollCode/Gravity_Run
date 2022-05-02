extends CanvasLayer

signal level_changed(level_name)

export (String) var level_name = "level"

onready var time_1 = $time_1
onready var time_2 = $time_2
onready var time_3 = $time_3

onready var total_time = $total_time

var time_text_1
var time_text_2
var time_text_3

var total_time_text

func _ready():
	
	time_text_1 = str(get_tree().get_root().get_node("GameInfo").level_times[0]) + " seconds"
	time_text_2 = str(get_tree().get_root().get_node("GameInfo").level_times[1]) + " seconds"
	time_text_3 = str(get_tree().get_root().get_node("GameInfo").level_times[2]) + " seconds"
	
	time_1.set_text(time_text_1)
	time_2.set_text(time_text_2)
	time_3.set_text(time_text_3)
	
	total_time_text = "Total time (in seconds):" + str(get_tree().get_root().get_node("GameInfo").level_times[0] + get_tree().get_root().get_node("GameInfo").level_times[1] + get_tree().get_root().get_node("GameInfo").level_times[2])
	
	total_time.set_text(total_time_text)
	

func next_level():
	get_tree().call_group("player", "signal_player_death")
	emit_signal("level_changed", level_name)

func _on_Button_pressed():
	get_tree().get_root().get_node("GameInfo").reset_level_tracker()
	emit_signal("level_changed", level_name)
