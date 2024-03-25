class_name PlayerJump extends State

func enter() -> void:
	super.enter()
	SignalBank.play_se.emit('Jump')
	if sprite_node.player_state == Enum.PlayerState.BIG and sprite_node.player_is_squat:
		animation_player.play(sprite_node.player_state + "Squat")
	else:
		animation_player.play(sprite_node.player_state + "Jump")

# 跳跃缓存
var _jump_buffed: bool = false

## 控制跳跃时的碰撞
func _handle_movement_collision(_collision: KinematicCollision2D):
	var _collider = _collision.get_collider()
	# 碰到砖的情况
	if _collider is StaticObject:
		if _collider is Pip:
			return
		var collision_angle = rad_to_deg(_collision.get_angle())
		if roundf(collision_angle) == 180:
			_collider.bump(sprite_node.player_state)

func physics_update(_delta: float) -> void:
	super.physics_update(_delta)
	var collision = sprite_node.get_last_slide_collision()
	if collision != null:
		_handle_movement_collision(collision)
	
	# 如果角色正向下移动, 且jump_buff_detector探测到落脚点, 则触发d
	if sprite_node.velocity.y > 0 and sprite_node.jump_buff_detector.is_colliding() and Input.is_action_just_pressed("move_jump"):
		print("jump_buffed")
		_jump_buffed = true

	# 如果松开跳跃键，减速
	if Input.is_action_just_released(("move_jump")):
		if sprite_node.velocity.y < sprite_node.JUMP_CUT:
			sprite_node.velocity.y -= sprite_node.JUMP_CUT
	if not sprite_node.is_on_floor():
		if sprite_node.direction:
			if Input.is_action_pressed("move_action"):
				sprite_node.velocity.x = move_toward(sprite_node.velocity.x, sprite_node.direction * sprite_node.MAX_SPEED, sprite_node.AIR_ACCELERATION * _delta)
			else:
				sprite_node.velocity.x = move_toward(sprite_node.velocity.x, sprite_node.direction * sprite_node.MAX_SPEED * sprite_node.WALK_THRESHOLD, sprite_node.ACCELERATION * _delta)
		else:
			sprite_node.velocity.x = move_toward(sprite_node.velocity.x, 0, sprite_node.AIR_DECELERATION * _delta)
	else:
		if _jump_buffed:
			sprite_node.velocity.y = sprite_node.JUMP_VELOCITY
			_jump_buffed = false
			transitioned.emit(self, 'PlayerJump')
		else:
			transitioned.emit(self, 'PlayerIdle')
