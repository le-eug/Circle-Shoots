extends Node

var level = 1

enum States {INITIAL, WON, LOST}
var state : States

func increment_level():
	level += 1

var population_array : Array = [0,0]
var populations_by_level : Array = []
func create_populations_by_level():
	# create array of 
	var base_value = 1
	var current_value = base_value
	
	while population_array[1] != 12:
		population_array[0] = current_value
		current_value -= 1
		
		population_array[1] = base_value - population_array[0]
		
		if current_value < 0:
			base_value += 1
			current_value = base_value
		
		populations_by_level.append(population_array.duplicate()) # must use duplicate as to not change the previous indices of populations_by_level
