extends Node2D

@export var player : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	
	if !player:
		print("ERROR: DODGE TIMER CANT FIND PLAYER RAAA")
		return


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if player.environment.state != player.environment.States.PLAYING:
		return
	
	visible = true
	
	if player.state == player.States.DODGING:
		scale.x = player.dodge_timer.time_left
	else:
		
		if Input.is_action_pressed("dodge"):
			scale.x = 0
		else:
			scale.x = 1
