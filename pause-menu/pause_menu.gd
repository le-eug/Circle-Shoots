extends Control

@export var environment : Node2D

enum States {PAUSED, UNPAUSED}
var state : States


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = States.UNPAUSED
	hide()

func _input(event: InputEvent) -> void:
	
	if environment.state != environment.States.PLAYING:
		return
	
	if event.is_action_pressed("pause"):
		
		if state == States.PAUSED:
			
			# game when unpaused:
			get_tree().paused = false
			state = States.UNPAUSED
			hide()
		
		elif state == States.UNPAUSED:
			
			# game when paused:
			get_tree().paused = true
			state = States.PAUSED
			show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#print(state)


func _on_resume_pressed() -> void:
	AudioManager.rim_click.play()
	
	get_tree().paused = false
	state = States.UNPAUSED
	hide()


func _on_resume_mouse_entered() -> void:
	AudioManager.stick_hit.play()


func _on_quit_pressed() -> void:
	AudioManager.rim_click.play()
	get_tree().quit()


func _on_quit_mouse_entered() -> void:
	AudioManager.stick_hit.play()


func _on_main_menu_pressed() -> void:
	AudioManager.rim_click.play()
	
	get_tree().paused = false
	state = States.UNPAUSED
	hide()
	
	get_tree().change_scene_to_file("res://main menu/MainMenu.tscn")


func _on_main_menu_mouse_entered() -> void:
	AudioManager.stick_hit.play()
