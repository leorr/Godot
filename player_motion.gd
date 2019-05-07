extends KinematicBody2D

var motion = Vector2()
var speed = 350

func get_input():
	motion = Vector2()
	if Input.is_action_pressed("ui_right"):
		motion.x += 1
		$AnimatedSprite.play("walkright")

	if Input.is_action_pressed("ui_left"):
		motion.x -= 1
		$AnimatedSprite.play("walkleft")

	if Input.is_action_pressed("ui_up"):
		motion.y -= 1			#shit is inverted idk why
		$AnimatedSprite.play("walkup")

	if Input.is_action_pressed("ui_down"):
		motion.y += 1
		$AnimatedSprite.play("walkdown")
	motion= motion.normalized() * speed

func _physics_process(delta):
    get_input()
    move_and_slide(motion)
