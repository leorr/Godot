extends Sprite
onready var lights = get_node("lights")

func _ready():
	set_z_index(get_position().y)

func _on_Player_nether():
	lights.set_visible(false)

func _on_Player_reality():
	lights.set_visible(true)
