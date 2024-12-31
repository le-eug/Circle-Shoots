extends Node2D

@onready var environment = $Environment
@onready var anim_player = $AnimationPlayer
var basic_enemy = preload("res://enemy/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player.play("reveal")
	AudioManager.stick_hit.play()
	
func play_bass():
	AudioManager.bass_drum.play()
	
func play_snare():
	AudioManager.snare_drum.play()
	
func play_hihat():
	AudioManager.hihat.play()
	
func play_crash():
	AudioManager.crash.play()

var population_array : Array = [0,0]
var populations_by_level : Array = []
func create_populations_by_level():
	# create array of 
	var base_value = 1
	var current_value = base_value
	
	while population_array[1] != 12:
		population_array[0] = current_value
		current_value -= 1
		
		population_array[1] = base_value - population_array[0]
		
		if current_value < 0:
			base_value += 1
			current_value = base_value
		
		populations_by_level.append(population_array.duplicate()) # must use duplicate as to not change the previous indices of populations_by_level

func spawn_enemies():
	var enemies = []
	
	# temporary code
	var enemy_instance = basic_enemy.instantiate()
	add_child(enemy_instance)
	enemies.append(enemy_instance)
	enemy_instance.global_position = Vector2(144,290)
	
	# spawn enemies based on populations_by_level
	
	# for ever enemy, set their state to playing
	for enemy in enemies:
		enemy.state = enemy.States.CHASE


# called from animation player
func begin_play():
	environment.state = environment.States.PLAYING
	play_crash()
	
	# algorithm for spawning enemies
	spawn_enemies()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("test_button"):
		environment.state = environment.States.WON
