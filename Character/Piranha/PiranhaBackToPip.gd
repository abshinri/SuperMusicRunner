extends Area2D

@export var wait_time := 0.0

func _on_body_entered(body: Node2D) -> void:
	if body is Piranha:
		if wait_time > 0:
			body.current_state = 4 # dance
			await get_tree().create_timer(wait_time).timeout
			body.back_to_pip()
		else:
			body.back_to_pip()
	pass # Replace with function body.
