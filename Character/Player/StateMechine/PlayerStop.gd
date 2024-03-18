class_name PlayerStop extends State

func enter() -> void:
	animation_player.play("stop")
	
func physics_update(_delta) -> void:
	super.physics_update(_delta)
	if sprite_node.direction:
			sprite_node.velocity.x = move_toward(sprite_node.velocity.x, sprite_node.direction * sprite_node.MAX_SPEED, sprite_node.ACCELERATION * _delta)
	else:
		sprite_node.velocity.x = move_toward(sprite_node.velocity.x, 0, sprite_node.DECELERATION * _delta)
			
	if sprite_node.velocity.x == 0:
		transitioned.emit(self,'PlayerIdle')
	## 加速度和移动方向相同时
	if sprite_node.direction * sprite_node.velocity.x > 0:
		if abs(sprite_node.velocity.x) < sprite_node.WALK_THRESHOLD * sprite_node.MAX_SPEED:
			transitioned.emit(self,'PlayerWalk')
		if abs(sprite_node.velocity.x) > sprite_node.WALK_THRESHOLD * sprite_node.MAX_SPEED:
			transitioned.emit(self,'PlayerRun')
			
	if Input.is_action_just_pressed("move_jump") and sprite_node.is_on_floor():
		sprite_node.velocity.y = sprite_node.JUMP_VELOCITY
		transitioned.emit(self, 'PlayerJump')
