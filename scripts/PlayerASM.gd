extends "res://scripts/State_Machine.gd"

signal nether
signal reality

func _ready():
	add_state("reality")
	add_state("nether")
	call_deferred("set_state",states.reality)

func _get_transition(delta):#transition is to return
	match state:
		states.nether:
			if Input.is_action_pressed("action"):
				return states.nether
			else:
				return states.reality
		states.reality:
			if Input.is_action_pressed("action"):
				return states.nether
			else:
				return states.reality

func _enter_state(new_state,old_state):
	match new_state:
		states.nether:
			parent.set_energy(float(1))
			emit_signal("nether")
		states.reality:
			parent.set_energy(float(0.1))
			emit_signal("reality")
