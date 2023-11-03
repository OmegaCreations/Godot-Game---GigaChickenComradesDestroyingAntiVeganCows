extends CharacterBody2D

@export var projectile_speed = 2
@export var direction : Vector2 = Vector2.ZERO

# Getters
@onready var player = get_tree().get_first_node_in_group("player")
@onready var kill_sound = $"/root/GameLevel/KillSound"

func _physics_process(_delta):
	velocity = direction.normalized() * projectile_speed
	var collision = move_and_collide(velocity)
	
	if collision and collision.get_collider().is_in_group("enemy"):
		kill_sound.play()

		player.score += 20
		collision.get_collider().queue_free()
		self.queue_free()

# Rotate da chicken
func _on_timer_timeout():
	self.rotation += 2

# Time to live of projectile
func _on_ttl_timeout():
	self.queue_free()
