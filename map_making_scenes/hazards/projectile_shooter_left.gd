extends Node2D

onready var bullet_timer = $bullet_timer
var bullet = load("res://map_making_scenes/hazards/laser_bullet_right.tscn")
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var my_random_number = rng.randf_range(0.5, 3.0)
	#starts platform movement at different times so they are not uniform
	bullet_timer.set_wait_time(my_random_number)
	bullet_timer.start()

func _on_bullet_timer_timeout():
	var bullet_instance = bullet.instance()
	var new_position = Vector2(position.x + 5, position.y)
	bullet_instance.position = new_position
	get_tree().get_root().add_child(bullet_instance)
	
	rng.randomize()
	var my_random_number = rng.randf_range(0.5, 3.0)
	#starts platform movement at different times so they are not uniform
	bullet_timer.set_wait_time(my_random_number)
	bullet_timer.start()

