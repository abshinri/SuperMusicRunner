class_name PlayerSquat extends State

func enter() -> void:
	super.enter()
	if sprite_node.player_state == Enum.PlayerState.BIG:
		animation_player.play(sprite_node.player_state + "Squat")
	else:
		transitioned.emit(self, 'PlayerIdle')
		
	
func physics_update(_delta) -> void:
	super.physics_update(_delta)
	if not sprite_node.is_on_floor():
		transitioned.emit(self,'PlayerJump')
	if Input.is_action_just_pressed("move_jump") and sprite_node.is_on_floor():
		sprite_node.velocity.y = sprite_node.JUMP_VELOCITY
		transitioned.emit(self, 'PlayerJump')
	if Input.is_action_just_released("move_down"):
		transitioned.emit(self, 'PlayerIdle')
	sprite_node.velocity.x = move_toward(sprite_node.velocity.x, 0, sprite_node.DECELERATION * _delta)
