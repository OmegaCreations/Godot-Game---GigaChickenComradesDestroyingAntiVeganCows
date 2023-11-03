extends CharacterBody2D

# Cow states
enum COW_STATE { IDLE, WALK }

# Basic timers and variables for cow
@export var move_speed : float = 30
@export var idle_time : float = 5
@export var walk_time : float = 2

# Getters
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D
@onready var timer = $Timer

# Starting setup
var move_direction : Vector2 = Vector2.ZERO
var current_state : COW_STATE = COW_STATE.IDLE

func _ready():
	new_state()

func _physics_process(_delta):
	if(current_state == COW_STATE.WALK):
		velocity = move_direction * move_speed
		move_and_slide()


# Chose new random direction
func select_direction():
	move_direction = Vector2(
		randi_range(-1, 1),
		randi_range(-1, 1)
	)
	
	if(move_direction.x < 0):
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
# Switch states
func new_state():
	if(current_state == COW_STATE.IDLE):
		current_state = COW_STATE.WALK
		state_machine.travel("Walk")
		select_direction()
		timer.start(walk_time)
	else:
		current_state = COW_STATE.IDLE
		state_machine.travel("Idle")
		timer.start(idle_time)


func _on_timer_timeout():
	new_state()
