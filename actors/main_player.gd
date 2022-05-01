extends KinematicBody2D


const SPEED = 150
const UP = Vector2(0, -1)
const JUMP_SPEED = 185
var character_motion = Vector2(0,0)
var jump_gravity_increment = 5

var alive = true
var current_ressurect_location
onready var revive_timer = $revive_timer

var apply_gravity = true

var character_direction = "right"
onready var character_animation = $AnimatedSprite

onready var right_beam = $right_beam
onready var left_beam = $left_beam
onready var up_beam = $up_beam

func _ready():
	set_ressurection_location()

func _physics_process(_delta):
	basic_movement()
	move_and_slide(character_motion, UP)
	activate_gravity_gun()
	set_beam_collisions()
	
func basic_movement():
	
	if Input.is_action_pressed("right"):
		character_motion.x = SPEED 
		set_animation("right")
		set_character_direction("right")
	elif Input.is_action_pressed("left"):
		character_motion.x = -SPEED 
		set_animation("left")
		set_character_direction("left")
	elif Input.is_action_pressed("up"):
		set_animation("up")
		set_character_direction("up")
	else: 
		
		if !Input.is_action_pressed("gravity_gun"):
			character_motion.x = 0
		set_animation("none")
		
	#jump	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		character_motion.y = -JUMP_SPEED
		jump_gravity_increment = 5
		apply_gravity = true
	elif is_on_floor():
		jump_gravity_increment = 5
	else: 
			#falling code
			if apply_gravity == true:		
				character_motion.y += 4 + jump_gravity_increment 
			
				if jump_gravity_increment > 1:
					jump_gravity_increment -= .50

func set_animation(setting):
	
	if setting == "right" and Input.is_action_pressed("gravity_gun"):
		character_animation.set_animation("default")
		character_animation._set_playing(false)
		character_animation.set_flip_h(false)
	elif setting == "left" and Input.is_action_pressed("gravity_gun"):
		character_animation.set_animation("default")
		character_animation._set_playing(false)
		character_animation.set_flip_h(true)
	elif setting == "right":
		character_animation.set_animation("run")
		character_animation._set_playing(true)
		character_animation.set_flip_h(false)
	elif setting == "left":
		character_animation.set_animation("run")
		character_animation._set_playing(true)
		character_animation.set_flip_h(true)
	elif setting == "up":
		character_animation.set_animation("default")
		character_motion.x = 0
		character_animation.set_frame(1)
	else:
		character_animation.set_animation("default")
		character_animation._set_playing(false)

func set_character_direction(setting):
	
	character_direction = setting

func activate_gravity_gun():
	
	if Input.is_action_pressed("gravity_gun") and character_direction == "right":
		right_beam.set_visible(true)
	
		left_beam.set_visible(false)
		up_beam.set_visible(false)
	elif Input.is_action_pressed("gravity_gun") and character_direction == "left":
		left_beam.set_visible(true)
		
		right_beam.set_visible(false)
		up_beam.set_visible(false)
	elif Input.is_action_pressed("gravity_gun") and character_direction == "up":
		up_beam.set_visible(true)
		
		right_beam.set_visible(false)
		left_beam.set_visible(false)
	else: 
		right_beam.set_visible(false)
		left_beam.set_visible(false)
		up_beam.set_visible(false)
		apply_gravity = true

#toggling based on player actions
func set_beam_collisions():
	
	if Input.is_action_pressed("gravity_gun") and character_direction == "up":
		$up_beam/Area2D/CollisionPolygon2D.set_disabled(false)
	elif Input.is_action_pressed("gravity_gun") and character_direction == "right":
		$right_beam/Area2D/CollisionPolygon2D.set_disabled(false)
	else:
		$up_beam/Area2D/CollisionPolygon2D.set_disabled(true)
		$right_beam/Area2D/CollisionPolygon2D.set_disabled(true)
		
#toggling gravity and motion based on gravity beam Area2d collisions
#no left beam yet				
func _on_Area2D_right_beam_area_entered(area):
	print(area, " -area", area)
	character_motion.x = 50
	character_motion.y = -55
	jump_gravity_increment = 5
	apply_gravity = false
	
func _on_Area2D_right_beam_area_shape_exited(_area_rid, area, _area_shape_index, _local_shape_index):
	apply_gravity = true

func _on_Area2D_up_beam_area_entered(_area):
	character_motion.y = -100
	jump_gravity_increment = 5
	apply_gravity = false
	#print("Change")
	
func _on_Area2D_up_beam_area_shape_exited(_area_rid, _area, _area_shape_index, _local_shape_index):
	apply_gravity = true		
		
func check_death_collisions():
	pass

#player has died, starting revive process
func signal_player_death():
	alive = false
	revive_timer.start()
	
#revives at specified ressurect location		
func _on_revive_timer_timeout():
	alive = true
	self.position = current_ressurect_location
	character_motion.y = 0
	
#every goal post resets ressurect location, and spawning into first level via "ready"
#called externally via goal_post	
func set_ressurection_location():
		current_ressurect_location = self.position

#toggle death based on hazard collision
func _on_interactive_area2D_area_entered(area):
	
	#checks if it's a corresponding game hazard, otherwise do nothing
	
	#only 1 type so far
	if area.get_parent().get_parent().is_in_group("lasers"):
		alive = false
		signal_player_death()
		print("player death script active")
		
			
	
	
	
