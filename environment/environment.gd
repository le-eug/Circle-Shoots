extends Node2D

enum States {
	DARK, 
	RANDOMIZE, 
	REVEALING_ROOMS,
	PLAYING, 
	WON, 
	LOST,
	}
	
var state : States
var sound_played : bool
@export var room_node_paths : Array
@export var rooms : Array
var eligible_for_center = [0,1,2,4] # room num is +1 of each of these

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = States.RANDOMIZE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	state_handler(delta)

var rng = RandomNumberGenerator.new()
func state_handler(delta):
		
	if state == States.RANDOMIZE:
		
		# make sound played be false 
		
		# go thru each room node and randomize its room
		var choice_history = []
		for room_node_path in room_node_paths:
			
			# randomize the room choice
			var room_node = get_node(room_node_path)
			var random_var : int
			
			# ensure this isnt a number picked before and if center room, its eligible
			while true:
				random_var = rng.randi_range(0, len(rooms)-1)
				
				# if already picked before
				if random_var in choice_history:
					continue # go back to top of the loop
					
				# if already picked before and not a center room, valid room
				if room_node.name != "5":
					break
				
				# check if the rand is eligible
				if random_var in eligible_for_center:
					break # if eligible, valid room
			
			choice_history.append(random_var)
			
			# get the room from the room choice
			var room_choice = rooms[random_var].instantiate()
			
			# place the room choice in each node
			add_child(room_choice)
			room_choice.position = room_node.position
		
		# go to state: revealing rooms
		state = States.REVEALING_ROOMS
		
	if state == States.REVEALING_ROOMS:
		pass
		
	if state == States.PLAYING:
		pass
		
		# if all the enemies are dead, won
		
		# if player dead, lost 
		
	if state == States.WON:
		
		# game state is won
		GameState.state = GameState.States.WON
		
		# increment level by 1 
		GameState.level += 1
		
		get_tree().change_scene_to_file("res://intermission/intermission.tscn")
		
	if state == States.LOST:
		
		# game state is lost
		GameState.state = GameState.States.LOST
		
		get_tree().change_scene_to_file("res://intermission/intermission.tscn")
		pass
