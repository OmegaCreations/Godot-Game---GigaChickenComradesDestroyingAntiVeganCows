# A area node should be added to CanvasItem (or child of it) element

extends Area2D
class_name HideArea 

@onready var sprite = get_parent()
@onready var player = get_tree().get_first_node_in_group("player")

# some further interaction possibility
# var interact: Callable = func():
# 	pass

func _ready():
	sprite.visible = true

func _on_body_entered(body):
	if body == player:
		sprite.visible = false


func _on_body_exited(body):
	if body == player:
		sprite.visible = true
