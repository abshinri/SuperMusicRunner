class_name Goomba extends MoveableObject
func _physics_process(_delta: float) -> void:
	super._physics_update(_delta)

func packed() -> void:
	state = Enum.EnemyState.DEAD
	velocity = Vector2(0,0)
	set_collision_mask_value(1, false)
	set_collision_layer_value(2, false)
	$AnimationPlayer.play("Dead")
	await $AnimationPlayer.animation_finished
	queue_free()

func _on_packed_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.global_position.y< global_position.y-4:
		body.velocity.y = -80
		packed()
