# Mask Layer powinien być taki jak Physical Layer Gracza!
# Add "interact" button in project settings
# Add player into "player" group inside of "Node -> Groups tab" next to Inspector tab on right

extends Area2D

class_name InteractionArea 

@export var action_name : String = "interact"

var interact: Callable = func():
	pass


func _on_body_entered(_body):
	InteractionManager.register_area(self)


func _on_body_exited(_body):
	InteractionManager.unregister_area(self)
