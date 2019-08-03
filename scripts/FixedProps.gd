extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var lights = get_node("lights")
# Called when the node enters the scene tree for the first time.
func _ready():
	set_z_index(get_position().y)


func _on_Player_nether():
	
	lights.set_visible(false)

func _on_Player_reality():
	lights.set_visible(true)