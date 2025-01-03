extends Enemy

var player
@onready var nav_agent = $NavigationAgent2D
@export var speed = 350

func state_handler(delta: float) -> void:
	if state == States.INITIAL:
		pass
	
	if state == States.CHASE:
		movement(delta)
		
		if condition_for_attack:
			state = States.ATTACK
		
	if state == States.ATTACK:
		
		if player.state != player.States.DODGING:
			player.state = player.States.DEAD
		
		if !condition_for_attack:
			state = States.CHASE
		
	if state == States.DEAD:
		
		visible = false

func movement(delta : float) -> void:
	var dir = nav_agent.get_next_path_position() - global_position
	velocity = dir * speed * delta
	move_and_slide()

func make_path() -> void:
	nav_agent.target_position = player.global_position

func _on_timer_timeout() -> void:
	make_path()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("../Player")
	if !player:
		print("NO PLAYER AAAAAA")

var min_distance = 30
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	state_handler(delta)
	condition_for_attack = global_position.distance_to(player.global_position) < min_distance
