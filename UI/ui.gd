extends CanvasLayer

# Canvas group with all projectiles
@export var bullets_canvas : Node2D

# Getters
@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label
@onready var counter = bullets_canvas.get_children().size()


func _process(_delta):
	# Ammount of bullets = Size of canvas group
	counter = bullets_canvas.get_children().size()
	if counter != null:
		label.text = "Chickullets: %d" % counter
	
	# Setup player score view
	var score = player.score
	if score != null:
		$SocialScore.text = "SocialScore: %d" % score

# Game end timer
func _on_timer_timeout():
	$"/root/GameLevel".is_running = false
