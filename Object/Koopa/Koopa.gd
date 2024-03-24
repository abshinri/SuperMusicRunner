class_name Koopa extends MoveableObject
func _physics_process(_delta: float) -> void:
	super._physics_update(_delta)

func packed() -> void:
	state = Enum.EnemyState.DEAD
	velocity = Vector2.ZERO
	var current_position = position
	var shell: PackedScene = preload ("res://Object/Shell/Shell.tscn")
	var shell_instance = shell.instantiate()
	shell_instance.position = current_position
	shell_instance.move_speed = 0
	
	get_parent().add_child(shell_instance)
	queue_free()


func _on_packed_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.velocity.y = -80
		packed()
