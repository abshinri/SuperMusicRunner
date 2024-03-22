class_name PlayerWalk extends State

func enter():
	super.enter()
	animation_player.play(sprite_node.player_state + "Walk")
	
func physics_update(_delta: float) -> void:
	super.physics_update(_delta)
	if Input.is_action_pressed("move_down") and sprite_node.is_on_floor() and sprite_node.player_state == Enum.PlayerState.BIG:
		transitioned.emit(self, 'PlayerSquat')
		## 加速度和移动方向不同时, 同时速度达到触发刹车的阈值
	if sprite_node.direction * sprite_node.velocity.x < 0 and abs(sprite_node.velocity.x) < sprite_node.BRAKE_THRESHOLD * sprite_node.MAX_SPEED:
		transitioned.emit(self, 'PlayerStop')
	if sprite_node.direction:
		#如果移动的方向和加速度不一致，则加速减速
		if sprite_node.velocity.x * sprite_node.direction < 0:
			sprite_node.velocity.x = move_toward(sprite_node.velocity.x, 0, sprite_node.ACCELERATION * 2 * _delta)
		#移动速度不为0时且移动速度低于走路速度阈值，播放走路动画
		elif abs(sprite_node.velocity.x) < sprite_node.WALK_THRESHOLD * sprite_node.MAX_SPEED:
			sprite_node.velocity.x = move_toward(sprite_node.velocity.x, sprite_node.direction * sprite_node.MAX_SPEED * sprite_node.WALK_THRESHOLD, sprite_node.ACCELERATION * _delta)
		elif abs(sprite_node.velocity.x) >= sprite_node.WALK_THRESHOLD * sprite_node.MAX_SPEED and Input.is_action_pressed("move_action"):
			transitioned.emit(self, 'PlayerRun')
	else:
		sprite_node.velocity.x = move_toward(sprite_node.velocity.x, 0, sprite_node.DECELERATION * _delta)
		
	if sprite_node.velocity.x == 0:
		transitioned.emit(self, 'PlayerIdle')
		
	if Input.is_action_just_pressed("move_jump") and sprite_node.is_on_floor():
		sprite_node.velocity.y = sprite_node.JUMP_VELOCITY
		transitioned.emit(self, 'PlayerJump')
