class_name PlayerRun extends State

func enter() -> void:
	animation_player.play("run")
	
func physics_update(_delta) -> void:
	super.physics_update(_delta)
	if not Input.is_action_pressed("move_action"):
		transitioned.emit(self, 'PlayerWalk')
		
	## 加速度和移动方向不同时, 同时速度达到触发刹车的阈值
	if sprite_node.direction * sprite_node.velocity.x < 0 and abs(sprite_node.velocity.x) < sprite_node.BRAKE_THRESHOLD * sprite_node.MAX_SPEED:
		transitioned.emit(self, 'PlayerStop')
	#移动速度不为0时且移动速度低于走路速度阈值，播放走路动画
	if abs(sprite_node.velocity.x) < sprite_node.WALK_THRESHOLD * sprite_node.MAX_SPEED:
		transitioned.emit(self, 'PlayerWalk')
	else:
		if sprite_node.direction:
			sprite_node.velocity.x = move_toward(sprite_node.velocity.x, sprite_node.direction * sprite_node.MAX_SPEED, sprite_node.ACCELERATION * _delta)
		else:
			sprite_node.velocity.x = move_toward(sprite_node.velocity.x, 0, sprite_node.DECELERATION * _delta)

	if Input.is_action_just_pressed("move_jump") and sprite_node.is_on_floor():
		sprite_node.velocity.y = sprite_node.JUMP_VELOCITY
		transitioned.emit(self, 'PlayerJump')
