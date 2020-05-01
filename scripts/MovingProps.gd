extends Node2D
func _process(_delta):
	set_z_index(float(get_position().y))
