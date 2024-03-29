extends Sprite2D


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.game_state = 'victory'
	pass # Replace with function body.
