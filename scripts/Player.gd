extends RigidBody2D

var motion = Vector2()

onready var timer = get_node("StateMachine").get_node("Timer")
onready var colider = get_node("CollisionShape2D")

var speed = 100

func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(1)

func _apply_movement():
	set_linear_velocity(motion)

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
