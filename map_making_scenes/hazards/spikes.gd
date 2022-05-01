extends Node2D

onready var spike_1 = $Spike_1
onready var spike_2 = $Spike_2
onready var spike_3 = $Spike_3



func _ready():
	pass
	




func _on_Area2D_spike_1_area_entered(area):
	get_tree().call_group("player", "signal_player_death")
