# A area node should be added to CanvasItem (or child of it) element

extends Area2D
class_name FadeArea 

@onready var sprite = get_parent()
@onready var player = get_tree().get_first_node_in_group("player")

# some further interaction possibility
# var interact: Callable = func():
# 	pass

func _ready():
	sprite.modulate.a = 1

func _on_body_entered(body):
	if body == player:
		sprite.modulate.a = 0.5


func _on_body_exited(body):
	if body == player:
		sprite.modulate.a = 1



# check if element can fade
# func _can_fade(node):
# 	return "modulate" in node
