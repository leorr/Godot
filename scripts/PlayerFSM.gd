extends "res://scripts/State_Machine.gd"

var facing = 0
var pfacing =0 
var f1 = preload("res://f1.tres")
var f0 = preload("res://f0.tres")
onready var timer = get_node("Timer")

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
			parent.set_mass(0.000001)
			parent.set_physics_material_override(f0)
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
			match facing:
				0:
					parent.get_node("anim_player").play("DodgeD")
				1:
					parent.get_node("anim_player").set_flip_h(false)
					parent.get_node("anim_player").play("DodgeH")
				2:
					parent.get_node("anim_player").play("DodgeU")
				3:
					parent.get_node("anim_player").set_flip_h(true)
					parent.get_node("anim_player").play("DodgeH")
					
		states.pushing:
			parent.set_mass(1)
			parent.set_physics_material_override(f1)
			if parent.motion.x == 0:
				if parent.motion.y > 0:
					facing = 0
				else:
					facing = 2
				
			if (!parent.get_node("audio_player").is_playing()):
				parent.get_node("audio_player").play()
			match facing:
				0:
					parent.get_node("anim_player").play("WalkD")
				1:
					parent.get_node("anim_player").set_flip_h(false)
					parent.get_node("anim_player").play("PushingH")
				2:
					parent.get_node("anim_player").play("PushingU")
				3:
					parent.get_node("anim_player").set_flip_h(true)
					parent.get_node("anim_player").play("PushingH")
		states.dodge:
			match facing:
				0:
					parent.get_node("anim_player").play("DodgeD")
				1:
					parent.get_node("anim_player").set_flip_h(false)
					parent.get_node("anim_player").play("DodgeH")
				2:
					parent.get_node("anim_player").play("DodgeU")
				3:
					parent.get_node("anim_player").set_flip_h(true)
					parent.get_node("anim_player").play("DodgeH")


func _on_Timer_timeout():
	set_state(states.walking)

func _on_Player_body_exited(_body):
	set_state(states.walking)
