extends KinematicBody2D

var motion = Vector2()
var speed = 100


func get_input():
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

func _physics_process(delta):
	set_z_index(get_position().y+50)
	print(get_z_index()," player")
	get_input()
	move_and_slide(motion)
