extends CharacterBody2D

@export var in_testing_garden : bool
@export var speed = 400
@onready var gun = $Gun
@onready var shoot_point = $Gun/ShootPoint
@export var bullet_speed = 1000

enum States {INITIAL, MOVING, DEAD, DODGING}
var state : States

@export var environment : Node2D

@onready var shoot_timer = $ShootTimer
var can_shoot : bool

var default_speed
var dodging_speed
var dodging_multiplier = 1.5

@onready var dodge_timer = $DodgingTimer

func basic_movement():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction.normalized() * speed
	move_and_slide()
	
func rotate_gun():
	gun.look_at(get_global_mouse_position())

func shoot_handler():
	if Input.is_action_pressed("shoot") && can_shoot:
		
		# instantiate the bullet object 
		var bullet_obj = load("res://bullet/Bullet.tscn").instantiate()
		add_sibling(bullet_obj)
		bullet_obj.rotation = gun.rotation
		bullet_obj.global_position = shoot_point.global_position
		bullet_obj.apply_impulse(Vector2(bullet_speed,0).rotated(gun.rotation), shoot_point.global_position)
		
		# play sfx
		AudioManager.shoot.play()
		
		# shoot_timer for cooldown
		can_shoot = false
		shoot_timer.start()

func _ready() -> void:
	can_shoot = true
	state = States.INITIAL
	
	default_speed = speed
	dodging_speed = dodging_multiplier * speed

func _physics_process(delta):
	
	if state == States.INITIAL:
		
		if in_testing_garden:
			state = States.MOVING
			return
			
		# ensure the environment is in playing state 
		if environment.state == environment.States.PLAYING:
			state = States.MOVING
	
	if state == States.MOVING:
		
		speed = default_speed
		modulate.a = 1
		
		shoot_handler()
		basic_movement()
		
		# dodging
		if Input.is_action_just_pressed("dodge"):
			state = States.DODGING
			dodge_timer.start()
	
	if state == States.DODGING:
		
		speed = dodging_speed
		modulate.a = 0.5
		
		basic_movement()
		
		# spawn transparent after-images
		
		# play dodging audio
		
		if Input.is_action_just_released("dodge"):
			state = States.MOVING
	
	if state == States.DEAD:
		environment.state = environment.States.LOST
	
	# allow player to rotate gun unless dead
	if state != States.DEAD:
		rotate_gun()


func _on_shoot_timer_timeout() -> void:
	can_shoot = true


func _on_dodging_timer_timeout() -> void:
	state = States.MOVING
