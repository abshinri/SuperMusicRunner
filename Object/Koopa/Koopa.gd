class_name Koopa extends MoveableObject
func _physics_process(_delta: float) -> void:
	var collision = get_last_slide_collision()
	if collision != null:
		_handle_pack_collision(collision)
	super._physics_update(_delta)

func _handle_pack_collision(_collision: KinematicCollision2D):
	var collider = _collision.get_collider()
	# 被踩的情况
	if collider is Player:
		var collision_angle = rad_to_deg(_collision.get_angle())
		print(collision_angle)
		if roundf(collision_angle) == 90:
			print("被踩")
			packed()
			collider.velocity.y -= 100

func packed() -> void:
	var current_position = position
	var shell: PackedScene = preload ("res://Object/KoopaShell/KoopaShell.tscn")
	var shell_instance = shell.instantiate()
	shell_instance.position = current_position
	shell_instance.move_speed = 0
	get_parent().add_child(shell_instance)
	queue_free()
