class_name Goomba extends MoveableObject

func _ready() -> void:
	super._ready()
	print('Goomba_ready')
	can_dance = true

func _physics_process(_delta: float) -> void:
	super._physics_update(_delta)

func packed() -> void:
	SignalBank.play_se.emit('Squish')
	velocity = Vector2(0,0)
	set_collision_mask_value(1, false)
	set_collision_layer_value(2, false)
	$AnimationPlayer.play("Dead")
	await $AnimationPlayer.animation_finished
	queue_free()

func _on_packed_area_2d_body_entered(body: Node2D) -> void:
	if state == Enum.EnemyState.DEAD:
		return
	if body.name == "Player" and body.global_position.y< global_position.y-4:
		state = Enum.EnemyState.DEAD
		# 关闭碰撞
		$CollisionShape2D.disabled = true
		$PackedArea2D/CollisionShape2D.disabled = true
		body.velocity.y = -120
		packed()
