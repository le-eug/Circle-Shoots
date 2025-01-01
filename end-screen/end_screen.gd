extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_menu_pressed() -> void:
	AudioManager.rim_click.play()
	get_tree().change_scene_to_file("res://main menu/MainMenu.tscn")


func _on_main_menu_mouse_entered() -> void:
	AudioManager.stick_hit.play()


func _on_quit_pressed() -> void:
	AudioManager.rim_click.play()
	get_tree().quit()


func _on_quit_mouse_entered() -> void:
	AudioManager.stick_hit.play()
