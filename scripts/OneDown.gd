extends Area2D


func _on_OneDown_body_entered(body):
	if body.is_in_group("Player"):
		body.set_position(Vector2(body.get_position().x,body.get_position().y+2))


func _on_OneDown_body_exited(body):
	if body.is_in_group("Player"):
		body.set_position(Vector2(body.get_position().x,body.get_position().y-2))
