extends RigidBody2D

var motion = Vector2()

onready var atkDuration = get_node("StateMachine").get_node("AtkDuration")
onready var colider = get_node("CollisionShape2D")

var speed = 500

		
func _apply_movement():
	apply_central_impulse(motion)

func _atk(var facing):
	atkDuration.start()
	match facing:
		0: motion = Vector2(0,5)
		1: motion = Vector2(5,0)
		2: motion = Vector2(0,-5)
		3: motion = Vector2(-5,0)
	
	
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
