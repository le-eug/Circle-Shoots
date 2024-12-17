extends Control

@onready var anim_player = $AnimationPlayer
@onready var message_label = $Message
@onready var level_label = $Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player.play("intermission")
	
	level_label.text = "Level " + str(GameState.level)
	
	if GameState.state == GameState.States.INITIAL:
		message_label.text = "Welcome."
		
	elif GameState.state == GameState.States.WON:
		message_label.text = "Well done."
		
	else: # state = LOSS
		message_label.text = "Try again."

func play_bass():
	AudioManager.bass_drum.play()
	
func play_snare():
	AudioManager.snare_drum.play()
	
func proceed_to_main():
	get_tree().change_scene_to_file("res://main/main.tscn")
	
