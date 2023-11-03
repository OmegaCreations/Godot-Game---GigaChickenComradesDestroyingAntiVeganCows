extends Sprite2D

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var sprite = $Sprite2D
@onready var collision = $StaticBody2D/CollisionShape2D

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	

func _on_interact():
	self.frame = 2 if self.frame == 1 else 1
	collision.disabled = not collision.disabled
