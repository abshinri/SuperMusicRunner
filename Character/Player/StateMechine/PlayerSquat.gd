class_name PlayerSquat extends State

func enter() -> void:
	super.enter()
	if sprite_node.player_state == Enum.PlayerState.BIG:
		animation_player.play(sprite_node.player_state + "Squat")
	else:
		transitioned.emit(self, 'PlayerIdle')
		
	
func physics_update(_delta) -> void:
	super.physics_update(_delta)
	if  sprite_node.velocity.x == 0:
		var direction = Input.get_axis("move_left", "move_right")
		if direction < 0:
			sprite_node.get_node('Sprite2D').flip_h = true
		elif direction > 0:
			sprite_node.get_node('Sprite2D').flip_h = false
			
	if not sprite_node.is_on_floor():
		transitioned.emit(self,'PlayerJump')
	if Input.is_action_just_pressed("move_jump") and sprite_node.is_on_floor():
		sprite_node.velocity.y = sprite_node.JUMP_VELOCITY
		SignalBank.play_se.emit('Jump')
		transitioned.emit(self, 'PlayerJump')
	if Input.is_action_just_released("move_down"):
		transitioned.emit(self, 'PlayerIdle')
	sprite_node.velocity.x = move_toward(sprite_node.velocity.x, 0, sprite_node.DECELERATION * _delta)
