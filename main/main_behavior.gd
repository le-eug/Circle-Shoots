extends Node2D

@onready var environment = $Environment
@onready var anim_player = $AnimationPlayer
var basic_enemy = preload("res://enemy/basic_enemy.tscn")
var shoot_enemy = preload("res://enemy/shooting_enemy.tscn")
var enemies = []

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

func spawn_enemies():
	
	# spawn enemies based on populations_by_level
	for i in range(GameState.populations_by_level[GameState.level-1][0]):
		print("making basic enemy")
		var enemy_instance = basic_enemy.instantiate()
		add_child(enemy_instance)
		enemies.append(enemy_instance)
		# set position
	
	for i in range(GameState.populations_by_level[GameState.level-1][1]):
		var enemy_instance = basic_enemy.instantiate()
		add_child(enemy_instance)
		enemies.append(enemy_instance)
		
		# set position
	
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
	
	if environment.state != environment.States.PLAYING:
		return
	
	# check if all enemies are dead
	for enemy in enemies:
		if enemy.state != enemy.States.DEAD:
			return
	
	environment.state = environment.States.WON
	
	# play crash
	play_crash()
