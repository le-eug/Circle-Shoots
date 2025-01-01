extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.state = GameState.States.INITIAL

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	AudioManager.rim_click.play()
	get_tree().change_scene_to_file("res://intermission/intermission.tscn") 


func _on_quit_pressed() -> void:
	AudioManager.rim_click.play()
	get_tree().quit()


func _on_play_mouse_entered() -> void:
	AudioManager.stick_hit.play()


func _on_quit_mouse_entered() -> void:
	AudioManager.stick_hit.play()


func _on_controls_mouse_entered() -> void:
	AudioManager.stick_hit.play()


func _on_controls_pressed() -> void:
	AudioManager.rim_click.play()
	get_tree().change_scene_to_file("res://controls-menu/ControlsMenu.tscn")
