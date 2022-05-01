extends KinematicBody2D

const SPEED = 50
var UP = Vector2(0, -1)

var bullet_motion = Vector2(0,0)

func _ready():
	bullet_motion.x = SPEED 
	
func _physics_process(delta):
	
	move_and_slide(bullet_motion, UP)


func _on_Area2D_area_entered(area):
	get_tree().call_group("player", "signal_player_death")
	
func _on_queue_free_area2D_body_entered(body):
	print("QUE FREE")
	queue_free()
