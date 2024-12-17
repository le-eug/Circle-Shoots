extends Node

var level = 1

enum States {INITIAL, WON, LOST}
var state : States

func increment_level():
	level += 1
