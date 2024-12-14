extends CharacterBody2D

@export var speed = 400
@onready var gun = $Gun
@onready var shoot_point = $Gun/ShootPoint
@export var bullet_speed = 1000

func basic_movement():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction.normalized() * speed
	
func rotate_gun():
	gun.look_at(get_global_mouse_position())

func shoot_handler():
	if Input.is_action_just_pressed("shoot"):
		print("shoot")
		
		# instantiate the bullet object 
		var bullet_obj = load("res://bullet/Bullet.tscn").instantiate()
		add_sibling(bullet_obj)
		bullet_obj.rotation = gun.rotation
		bullet_obj.global_position = shoot_point.global_position
		bullet_obj.apply_impulse(Vector2(bullet_speed,0).rotated(gun.rotation), shoot_point.global_position)
		
		# timer for cooldown

func _physics_process(delta):
	basic_movement()
	rotate_gun()
	shoot_handler()
	move_and_slide()
