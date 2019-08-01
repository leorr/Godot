extends "res://scripts/State_Machine.gd"

var facing = 0 

func _ready():
	add_state("idle")
	add_state("walking")
	call_deferred("set_state",states.idle)

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
				if parent.motion.x !=0:
					if parent.motion.x >0:
						facing = 1
					else:
						facing = 3
				else:
					if parent.motion.y > 0:
						facing = 0
					else:
						facing = 2
				return states.walking

func _enter_state(new_state,old_state):
	match new_state:
		states.idle:
			match facing:
				0:
					parent.get_node("anim_player").play("idledown")
				1:
					parent.get_node("anim_player").play("idlehorizontal")
				3:
					parent.get_node("anim_player").play("idlehorizontal")
				2:
					parent.get_node("anim_player").play("idleup")


		states.walking:
			match facing:
				0:
					parent.get_node("anim_player").play("walkdown")
				1:
					parent.get_node("anim_player").set_flip_h(false)
					parent.get_node("anim_player").play("walkhorizontal")
				3:
					parent.get_node("anim_player").set_flip_h(true)
					parent.get_node("anim_player").play("walkhorizontal")
				2:
					parent.get_node("anim_player").play("walkup")

