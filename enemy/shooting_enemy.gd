extends Enemy

var player
@onready var nav_agent = $NavigationAgent2D
@export var speed = 350
@onready var gun = $Gun
var min_distance = 30
@onready var ray = $Gun/RayCast2D
@onready var shoot_timer = $Gun/ShootTimer
@onready var shoot_point = $Gun/ShootPoint
@export var bullet_speed = 500

func rotate_toward_player():
	gun.look_at(player.global_position) 

func state_handler(delta: float) -> void:
	
	rotate_toward_player()
	
	if state == States.INITIAL:
		return
	
	if state == States.CHASE:
		
		if !shoot_timer.is_stopped(): 
			shoot_timer.stop()
		
		movement(delta)
		
		if condition_for_attack:
			state = States.ATTACK
		
	if state == States.ATTACK:
		
		if shoot_timer.is_stopped(): 
			shoot_timer.start()
		
		if !condition_for_attack:
			state = States.CHASE
		
	if state == States.DEAD:
		
		visible = false
		shoot_timer.stop()

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	state_handler(delta)
	
	if !ray.get_collider():
		return
	
	condition_for_attack = ray.get_collider().name == player.name


func _on_shoot_timer_timeout() -> void:
	# shoot
	# instantiate the bullet object 
	var bullet_obj = load("res://bullet/Enemy-Bullet.tscn").instantiate()
	add_sibling(bullet_obj)
	bullet_obj.rotation = gun.rotation
	bullet_obj.global_position = shoot_point.global_position
	bullet_obj.apply_impulse(Vector2(bullet_speed,0).rotated(gun.rotation), shoot_point.global_position)
	
	# play sfx
	AudioManager.shoot.play()
