extends KinematicBody2D

var motion = Vector2()
var pmotion = Vector2()

onready var timer = get_node("StateMachine").get_node("Timer")

var speed = 115


signal nether
signal reality

func _apply_movement():
	move_and_slide(motion)

func _dodge():
	motion = motion * 4
	timer.start()

	
func _handle_move_input():
	motion = Vector2()
	if Input.is_action_pressed("ui_right"):
		motion.x += 1
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1
	if Input.is_action_pressed("ui_up"):
		motion.y -= 1
	if Input.is_action_pressed("ui_down"):
		motion.y += 1
	motion= motion.normalized() * speed
	pmotion = motion

func _on_StateMachine_nether():
	emit_signal("nether")

func _on_StateMachine2_reality():
	emit_signal("reality")
