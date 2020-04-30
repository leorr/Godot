extends KinematicBody2D

var lights = ["res://scenes/Lamp.tscn"]
var motion = Vector2()
var pmotion = Vector2()

onready var timer = get_node("StateMachine").get_node("Timer")
onready var colider = get_node("CollisionShape2D")

var speed = 100

#func _ready():
	#var num = 0
	#var currentlight = load(lights[num]).instance()
	#connect("reality",currentlight,"_on_Player_reality")
	#connect("nether",currentlight,"_on_Player_nether")
	

func _apply_movement():
	move_and_slide(motion)

func _dodge():
	motion = motion * 2.5
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
