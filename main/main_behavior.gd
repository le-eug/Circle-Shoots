extends Node2D

@onready var environment = $Environment
@onready var anim_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player.play("reveal")

func play_bass():
	AudioManager.bass_drum.play()
	
func play_snare():
	AudioManager.snare_drum.play()
	
func play_hihat():
	AudioManager.hihat.play()
	
func play_crash():
	AudioManager.crash.play()
	
func begin_play():
	environment.state = environment.States.PLAYING
	
	# algorith for spawning enemies

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("test_button"):
		environment.state = environment.States.LOST
		GameState.state = GameState.States.LOST
