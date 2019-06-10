extends KinematicBody2D

var motion = Vector2()
var speed = 100

signal right
signal left
signal down
signal up

func get_input():
	motion = Vector2()
	if Input.is_action_pressed("ui_right"):
		motion.x += 1
		emit_signal("right")
		
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1
		emit_signal("left")

	if Input.is_action_pressed("ui_up"):
		motion.y -= 1
		emit_signal("up")

	if Input.is_action_pressed("ui_down"):
		motion.y += 1
		emit_signal("down")
		
	motion= motion.normalized() * speed

func _physics_process(delta):
	set_z_index(get_position().y)
	get_input()
	move_and_slide(motion)


func _on_street_body_entered(body):
	set_position(Vector2(get_position().x,get_position().y+3))


func _on_street_body_exited(body):
		set_position(Vector2(get_position().x,get_position().y-3))