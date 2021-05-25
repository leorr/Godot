extends Area2D


func _on_OneDown_body_entered(body):
	if body.is_in_group("Player"):
		var animPlayer = body.get_node("anim_player")
		var collider = body.get_node("collider")
		animPlayer.set_position(Vector2(animPlayer.get_position().x,animPlayer.get_position().y+3))
		collider.set_position(Vector2(collider.get_position().x,collider.get_position().y+3))
		#TODO slow movement
	elif body.is_in_group("Props"):
		body.apply_central_impulse(Vector2(0,1000/2))


func _on_OneDown_body_exited(body):
	if body.is_in_group("Player"):
		var animPlayer = body.get_node("anim_player")
		var collider = body.get_node("collider")
		animPlayer.set_position(Vector2(animPlayer.get_position().x,animPlayer.get_position().y-3))
		collider.set_position(Vector2(collider.get_position().x,collider.get_position().y-3))
		#TODO slow movement
	elif body.is_in_group("Props"):
		body.apply_central_impulse(Vector2(0,-1000/2))

