extends CharacterBody2D
class_name Enemy

enum States {INITIAL, CHASE, ATTACK, DEAD}
var state : States
var condition_for_attack : bool

func _ready() -> void:
	state = States.INITIAL
