extends Node2D

@export var is_running : bool = true
const bg_tracks = [
	'bg_1',
	'bg_2',
	'bg_3'
]

# preloading for spawning entities
@onready var chicken_scene = preload("res://Characters/Chicken.tscn")
@onready var enemy_scene = preload("res://Characters/Cow.tscn")

# get player
@onready var player = get_tree().get_first_node_in_group("player")
@onready var music_player = $UI/BackgroundMusicPlayer

func _ready():
	play_music()

func _process(_delta):
	# Game ended - go for end screen
	if not is_running:
		$UI.visible = false
		$EndScreen.visible = true
		for node in $Bullets.get_children():
			node.queue_free()
		for node in $Enemies.get_children():
			node.queue_free()
		for node in $InteractableItems.get_children():
			node.queue_free()

# Spawn new chicken to pick up
func _on_bullet_spawner_timeout():
	var new_chicken = chicken_scene.instantiate()
	new_chicken.position = Vector2(randf_range(70, 700), randf_range(70, 500))
	new_chicken.collectable = true
	new_chicken.modulate = Color(1, 0.498039, 0.313726, 1)
	new_chicken.get_child(0).action_name = "[E] to recruit comrade" # Interaction manager's label text
	$InteractableItems.add_child(new_chicken)

# Spawn new cow
func _on_enemy_spawner_timeout():
	var new_enemy = enemy_scene.instantiate()
	new_enemy.position = Vector2(randf_range(70, 700), randf_range(70, 500))
	$Enemies.add_child(new_enemy)

# Restart the game upon pressing [R]
# This method is callable from EndScreen node
func restart():
	player.score = 0
	$UI/Panel/Timer.start(60)
	$UI.visible = true
	$EndScreen.visible = false
	is_running = true
	play_music()
	
	
# set new music
func play_music():
	music_player.stop()
	var rand_nb = randi_range(0, bg_tracks.size()-1)
	var audiostream = load('res://assets/Sounds/Background/' + bg_tracks[rand_nb] + '.mp3')
	music_player.set_stream(audiostream)
	music_player.play()
