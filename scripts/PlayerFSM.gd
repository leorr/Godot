extends "res://scripts/State_Machine.gd"

var facing = 0
onready var f1 = preload("res://tres/f1.tres")
onready var f0 = preload("res://tres/f0.tres")
onready var timer = get_node("Timer")
onready var animator = parent.get_node("anim_player")
onready var audio = parent.get_node("audio_player")

func _ready():
	add_state("idle")
	add_state("walking")
	add_state("dodge")
	add_state("pushing")
	call_deferred("set_state",states.idle)


func _refresh(_delta):
	parent.set_z_index(parent.get_position().y)
	parent._apply_movement()

func _update_state(_delta):
	match state:
		states.idle:
			parent._handle_move_input()
			if parent.motion.x != 0 || parent.motion.y !=0 :
				return states.walking

		states.walking:
			parent._handle_move_input()
			if parent.get_colliding_bodies() != [] && (parent.motion.x == 0 || parent.motion.y==0):
				return states.pushing
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
		states.pushing:
			parent._handle_move_input()
			if parent.motion == Vector2(0,0):
				parent._handle_move_input()
				return states.idle
			else:
				return states.pushing

func _enter_state(new_state,_old_state):
	match new_state:
		states.idle:
			audio.stop()
			match facing:
				0:
					animator.play("IdleD")
				1:
					animator.play("IdleH")
				2:
					animator.play("IdleU")
				3:
					animator.play("IdleH")

		states.walking:
			parent.set_mass(0.0000001)
			parent.set_physics_material_override(f0)
			if (!audio.is_playing()):
				audio.play()
			match facing:
				0:
					animator.play("WalkD")
				1:
					animator.set_flip_h(false)
					animator.play("WalkH")
				2:
					animator.play("WalkU")
				3:
					animator.set_flip_h(true)
					animator.play("WalkH")
		states.dodge:
			match facing:
				0:
					animator.play("DodgeD")
				1:
					animator.set_flip_h(false)
					animator.play("DodgeH")
				2:
					animator.play("DodgeU")
				3:
					animator.set_flip_h(true)
					animator.play("DodgeH")
					
		states.pushing:
			parent.set_mass(1)
			parent.set_physics_material_override(f1)
			if parent.motion.x == 0:
				if parent.motion.y > 0:
					facing = 0
				else:
					facing = 2
				
			if (!audio.is_playing()):
				audio.play()
			match facing:
				0:
					animator.play("WalkD")
				1:
					animator.set_flip_h(false)
					animator.play("PushingH")
				2:
					animator.play("PushingU")
				3:
					animator.set_flip_h(true)
					animator.play("PushingH")
		states.dodge:
			match facing:
				0:
					animator.play("DodgeD")
				1:
					animator.set_flip_h(false)
					animator.play("DodgeH")
				2:
					animator.play("DodgeU")
				3:
					animator.set_flip_h(true)
					animator.play("DodgeH")


func _on_Timer_timeout():
	set_state(states.walking)

func _on_Player_body_exited(_body):
	set_state(states.walking)
