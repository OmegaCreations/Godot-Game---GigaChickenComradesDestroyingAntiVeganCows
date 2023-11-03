extends CharacterBody2D

# Basic variables for chicken
@export var move_speed : float = 70
@export var bullets_canvas : Node2D

# If chicken is in collectable state
@export var collectable : bool = false

# Getters
@onready var player = get_tree().get_first_node_in_group("player")
@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D
@onready var collection_area : InteractionArea = $InteractionArea
@onready var collect_sound = $"/root/GameLevel/CollectSound"

#----------------------------------------------------------------------------
func _ready():
	# Interaction area manager
	collection_area.interact = Callable(self, "_on_collect_comrade")

func _physics_process(_delta : float) -> void:
	new_state()
	
	# Move if not collectable and distance is >40
	if self.global_position.distance_to(player.global_position) > 40 && not collectable:
		collection_area.monitoring = false
		collection_area.monitorable = false
		
		var direction = to_local(nav_agent.get_next_path_position()).normalized()
		
		update_animation_pos(direction)
		
		velocity = direction * move_speed
		move_and_slide()
	# Activate interaction area on collectable and stop from moving
	elif collectable:
		collection_area.monitoring = true
		collection_area.monitorable = true
		velocity = Vector2.ZERO

# Collection of chickens
func _on_collect_comrade():
	if collectable:
		collect_sound.play()
		
		collectable = false
		$"/root/GameLevel/Bullets".append_chicken(self)
	
# Crate path to player
func make_path():
	nav_agent.target_position = player.global_position

# Redraw path
func _on_timer_timeout():
	make_path()

# Update sprite direction
func update_animation_pos(move_input: Vector2):
	if(move_input.x < 0):
		sprite.flip_h = true
	else:
		sprite.flip_h = false

# Switch chicken animation states
func new_state():
	if(velocity != Vector2.ZERO && self.global_position.distance_to(player.global_position) > 40):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
