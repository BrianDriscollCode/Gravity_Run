extends Node2D


onready var up_and_down_movement = $AnimatedSprite/up_and_down 
onready var movement_timer = $AnimatedSprite/up_and_down/Timer
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var my_random_number = rng.randf_range(0.5, 3.0)
	
	#starts platform movement at different times so they are not uniform
	movement_timer.set_wait_time(my_random_number)
	movement_timer.start()

func _on_Timer_timeout():
	up_and_down_movement.play("up_and_down")
