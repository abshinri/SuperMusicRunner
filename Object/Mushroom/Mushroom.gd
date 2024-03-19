class_name Mushroom extends MoveableObject

func _physics_process(_delta: float) -> void:
	super._physics_update(_delta)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		queue_free()
	pass # Replace with function body.
