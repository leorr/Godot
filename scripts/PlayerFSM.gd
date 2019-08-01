extends "res://scripts/State_Machine.gd"

func _ready():
	add_state("idle")
	add_state("walking")
	call_deferred("set_state",states.walking)

func _state_logic(delta):
	parent._handle_move_input()
	parent._apply_movement()


func _get_transition(delta):#transition is to return
	match state:
		states.idle:
			if parent.motion.x == 0 && parent.motion.y ==0 :
				return states.idle
			else:
				return states.walking
		states.walking:
			if parent.motion.x == 0 && parent.motion.y ==0 :
				return states.idle
			else:
				return states.walking

func _enter_state(new_state,old_state):
	match new_state:
		states.idle:
			parent.get_node("anim_player").play("idledown")
		states.walking:
			parent.get_node("anim_player").play("walkdown")


