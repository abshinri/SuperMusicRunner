class_name PlayerRun extends State

func enter() -> void:
	super.enter()
	animation_player.play(sprite_node.player_state + "Run")
	$"../../Sprite2D/RunningDust".emitting = true

func exit() -> void:
	super.exit()
	$"../../Sprite2D/RunningDust".emitting = false

func physics_update(_delta) -> void:
	super.physics_update(_delta)
	if Input.is_action_pressed("move_down") and sprite_node.is_on_floor() and sprite_node.player_state == Enum.PlayerState.BIG:
		transitioned.emit(self, 'PlayerSquat')
	if not Input.is_action_pressed("move_action"):
		transitioned.emit(self, 'PlayerWalk')
		
	## 加速度和移动方向不同时, 刹车
	if sprite_node.direction * sprite_node.velocity.x < 0:
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
		SignalBank.play_se.emit('Jump')
		transitioned.emit(self, 'PlayerJump')
