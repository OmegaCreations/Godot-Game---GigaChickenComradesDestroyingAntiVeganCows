extends CharacterBody2D

# Basic variables for player
@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0, 0.1)
@export var score : int = 0

# Shooting system variables
@export var bullets_canvas : Node2D # a canvas group with all bullets
const projectilePath = preload("res://Objects/Projectile.tscn")

# Getters
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var shoot_sound_player = $ShootSound
@onready var empty_sound_player = $EmptySound

func _ready():
	update_animation_pos(starting_direction)


func _physics_process(_delta):
	# Shooting marker position as mouse
	$Marker2D.look_at(get_global_mouse_position())
	
	# Gun sprite rotation
	var ang = rad_to_deg((get_global_mouse_position() - $Marker2D/Sprite2D.global_position).angle())
	if abs(ang) > 90:
		$Marker2D/Sprite2D.flip_v = true
	elif ang < 90:
		$Marker2D/Sprite2D.flip_v = false
	
	
	# Shoot input
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	# Player's movement
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	
	update_animation_pos(input_direction)
	velocity = input_direction * move_speed
	new_state()
	move_and_slide()

# Update position vector inside of a animation tree
func update_animation_pos(move_input: Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
		

# Set new player animation state
func new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")

# Shooting logic
func shoot():
	if(bullets_canvas.get_children().size() > 0):
		# play shoot sound
		shoot_sound_player.play()
		
		var projectile = projectilePath.instantiate() # spawn new projectile
		self.add_child(projectile)
		
		projectile.position = $Marker2D/Sprite2D.global_position
		projectile.direction = get_global_mouse_position() - projectile.position
		
		# remove chicken each time we shoot a projectile
		bullets_canvas.remove_child(bullets_canvas.get_child(0))
	else:
		empty_sound_player.play()
