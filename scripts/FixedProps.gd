extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	set_z_index(get_position().y)
	print("props z:",get_z_index())
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
