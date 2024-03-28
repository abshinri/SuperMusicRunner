extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Piranha:
		body.back_to_pip()
	pass # Replace with function body.
