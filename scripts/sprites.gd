extends Node2D

onready var anim_speed = randf()*4+1
onready var anim1= get_node("light_sprite")
onready var anim2= get_node("light_sprite2")


# Called when the node enters the scene tree for the first time.
func _ready():
	anim1.set_speed_scale(anim_speed)
	anim2.set_speed_scale(anim_speed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
