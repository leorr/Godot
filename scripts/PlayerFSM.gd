extends "res://scripts/State_Machine.gd"

var facing = 0 
onready var timer = get_node("Timer")

func _ready():
	add_state("idle")
	add_state("walking")
	add_state("dodge")
	call_deferred("set_state",states.idle)


func _refresh(delta):
	parent.set_z_index(parent.get_position().y)
	parent._apply_movement()

func _update_state(delta):
	match state:
		states.idle:
			parent._handle_move_input()
			if parent.motion.x != 0 || parent.motion.y !=0 :
				return states.walking

		states.walking:
			parent._handle_move_input()
			if Input.is_action_just_pressed("action"):
				return states.dodge
			if parent.motion.x == 0 && parent.motion.y ==0 :
				parent._handle_move_input()
				return states.idle
			else:
				if parent.motion.x !=0:
					if parent.motion.x > 0:
						facing = 1
					else:
						facing = 3
				else:
					if parent.motion.y > 0:
						facing=0
					else:
						facing=2
				return states.walking
		states.dodge:
			parent._dodge()#stop handling the move input while in dodge
			yield(timer,"timeout")#wait the timer, see _on_Timer_timeout()

func _enter_state(new_state,old_state):
	match new_state:
		states.idle:
			parent.get_node("audio_player").stop()
			match facing:
				0:
					parent.get_node("anim_player").play("IdleD")
				1:
					parent.get_node("anim_player").play("IdleH")
				2:
					parent.get_node("anim_player").play("IdleU")
				3:
					parent.get_node("anim_player").play("IdleH")

		states.walking:
			if (!parent.get_node("audio_player").is_playing()):
				parent.get_node("audio_player").play()
			match facing:
				0:
					parent.get_node("anim_player").play("WalkD")
				1:
					parent.get_node("anim_player").set_flip_h(false)
					parent.get_node("anim_player").play("WalkH")
				2:
					parent.get_node("anim_player").play("WalkU")
				3:
					parent.get_node("anim_player").set_flip_h(true)
					parent.get_node("anim_player").play("WalkH")
		states.dodge:
			parent.get_node("anim_player").play("DodgeH")


func _on_Timer_timeout():
	set_state(states.walking)
