extends Node2D

@onready var environment = $Environment
@onready var anim_player = $AnimationPlayer
var basic_enemy = preload("res://enemy/basic_enemy.tscn")
var shooting_enemy = preload("res://enemy/shooting_enemy.tscn")
var enemies = []
@export var enemy_spawn_points : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player.play("reveal")
	AudioManager.stick_hit.play()
	
	# algorithm for spawning enemies
	spawn_enemies()
	
func play_bass():
	AudioManager.bass_drum.play()
	
func play_snare():
	AudioManager.snare_drum.play()
	
func play_hihat():
	AudioManager.hihat.play()
	
func play_crash():
	AudioManager.crash.play()

func spawn_enemies():
	
	# make duplicate so we can modify it
	var enemy_spawn_points_duplicate = enemy_spawn_points.duplicate()
	
	# spawn enemies based on populations_by_level
	# BASIC ENEMIES
	for i in range(GameState.populations_by_level[GameState.level-1][0]):
		
		var enemy_instance = basic_enemy.instantiate()
		add_child(enemy_instance)
		enemies.append(enemy_instance)
		
		# SET POSITION
		# random choice from spawn points
		var rand_choice = enemy_spawn_points_duplicate.pick_random()
		
		# remove from duplicate array
		enemy_spawn_points_duplicate.erase(rand_choice)
		
		# set position
		enemy_instance.position = get_node(rand_choice).position
	
	# SHOOTING ENEMIES
	for i in range(GameState.populations_by_level[GameState.level-1][1]):
		
		var enemy_instance = shooting_enemy.instantiate()
		add_child(enemy_instance)
		enemies.append(enemy_instance)
		
		# SET POSITION
		# random choice from spawn points
		var rand_choice = enemy_spawn_points_duplicate.pick_random()
		
		# remove from duplicate array
		enemy_spawn_points_duplicate.erase(rand_choice)
		
		# set position
		enemy_instance.position = get_node(rand_choice).position

# called from animation player
func begin_play():
	environment.state = environment.States.PLAYING
	play_crash()
	
	# for ever enemy, set their state to playing
	for enemy in enemies:
		enemy.state = enemy.States.CHASE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if environment.state != environment.States.PLAYING:
		return
	
	# check if all enemies are dead
	for enemy in enemies:
		if enemy.state != enemy.States.DEAD:
			return
	
	environment.state = environment.States.WON
	
	# play crash
	play_crash()
