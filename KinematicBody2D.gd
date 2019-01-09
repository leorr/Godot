extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var motion = Vector2()
const UP = Vector2(0,-1)

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		motion.x = 280
		$AnimatedSprite.play("Walking")
		$AnimatedSprite.flip_h=0
	elif Input.is_action_pressed("ui_left"):
		motion.x = -280
		$AnimatedSprite.play("Walking")
		$AnimatedSprite.flip_h=1
	else:
		$AnimatedSprite.play("Idle")
		motion.x = 0
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -700
	else:
		if motion.y <= 0:
			motion.y += 60
		else:
			motion.y += 70
	
	move_and_slide(motion,UP)
	pass
