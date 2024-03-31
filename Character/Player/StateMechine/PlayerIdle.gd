class_name PlayerIdle extends State

func enter() -> void:
	super.enter()
	animation_player.play(sprite_node.player_state + "Idle")
	
func physics_update(_delta) -> void:
	super.physics_update(_delta)
	if not sprite_node.is_on_floor():
		transitioned.emit(self,'PlayerJump')
	if sprite_node.direction:
		transitioned.emit(self,'PlayerWalk')
	if Input.is_action_just_pressed("move_jump") and sprite_node.is_on_floor():
		sprite_node.velocity.y = sprite_node.JUMP_VELOCITY
		SignalBank.play_se.emit('Jump')
		transitioned.emit(self, 'PlayerJump')
	if Input.is_action_pressed("move_down") and sprite_node.is_on_floor() and sprite_node.player_state == Enum.PlayerState.BIG:
		transitioned.emit(self, 'PlayerSquat')
	sprite_node.velocity.x = move_toward(sprite_node.velocity.x, 0, sprite_node.DECELERATION * _delta)
