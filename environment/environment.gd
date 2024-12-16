extends Node2D

enum States {
	DARK, 
	RANDOMIZE, 
	PLAYING, 
	WON, 
	LOST,
	}
	
var state : States
var sound_played : bool
@export var room_node_paths : Array
@export var rooms : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = States.DARK

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	state_handler()

var rng = RandomNumberGenerator.new()
func state_handler():
	if state == States.DARK:
		pass
		
		# play sound effect if not alrdy played 
		
		# make screen dark
		
		# timer before displaying text
		
		# display the text
		
		# set played to true
		
		# set to state: randomize 
		state = States.RANDOMIZE
		
	if state == States.RANDOMIZE:
		
		# make sound played be false 
		
		# go thru each room node and randomize its room
		var choice_history = []
		for room_node_path in room_node_paths:
			
			# randomize the room choice
			var room_node = get_node(room_node_path)
			var random_var : int = rng.randi_range(0, len(rooms)-1) # for some reason its -1
			
			# ensure this isnt a number picked before
			while true:
				if random_var in choice_history:
					random_var = rng.randi_range(0, len(rooms)-1) 
				else:
					break
			
			choice_history.append(random_var)
			
			# get the room from the room choice
			var room_choice = rooms[random_var].instantiate()
			
			# place the room choice in each node
			add_child(room_choice)
			room_choice.position = room_node.position
		
		# go to state: playing
		state = States.PLAYING
		
	if state == States.PLAYING:
		pass
		
		# disable the darkness
		
		# summon enemies, if not already
		
		# if all the enemies are dead, won
		
		# if player dead, lost 
		
	if state == States.WON:
		pass
		
		# increment level by 1 
		
		# go back to state: dark
		state = States.DARK
		
	if state == States.LOST:
		
		# go back to state: dark
		state = States.DARK
		
		pass
