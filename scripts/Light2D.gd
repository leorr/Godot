extends Light2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_z_range_max(get_z_index()+20)
	set_z_range_min(get_z_index()-20)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass