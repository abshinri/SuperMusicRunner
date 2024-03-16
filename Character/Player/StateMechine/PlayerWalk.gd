class_name PlayerWalk extends State

func enter():
	animation_player.play("walk")
	
func update(_delta: float) -> void:
	if sprite_node.direction:
		#移动速度不为0时且移动速度低于走路速度阈值，播放走路动画
		if abs(sprite_node.velocity.x) < sprite_node.WALK_THRESHOLD * sprite_node.MAX_SPEED:
			if sprite_node.direction:
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
