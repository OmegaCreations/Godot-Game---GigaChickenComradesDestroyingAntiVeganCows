extends CanvasGroup

@onready var player = get_tree().get_first_node_in_group("player")
@onready var chicken = load("res://Characters/Chicken.tscn")

func _ready():
	pass

# Append chicken after collecting it
# Idea - remove current one and instantiate new one into group
func append_chicken(node):
	node.queue_free()
	var new_chicken = chicken.instantiate()
	new_chicken.collectable = false
	new_chicken.position = player.global_position
	new_chicken.get_child(0).action_name = ""
	self.add_child(new_chicken)
