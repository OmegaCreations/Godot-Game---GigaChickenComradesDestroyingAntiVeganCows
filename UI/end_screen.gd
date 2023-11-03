
extends CanvasLayer

@onready var player = get_tree().get_first_node_in_group("player")

func _process(_delta):
	# Process player score into UI label
	$SocialScore.text = "Social Score: %d" % player.score
	
	# Call Game.gd restart method
	if Input.is_action_just_pressed("restart") && self.visible == true:
		$"/root/GameLevel".restart()
