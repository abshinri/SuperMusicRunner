class_name PlayerJump extends State

func enter() -> void:
	animation_player.play("jump")
	
func update(_delta: float) -> void:
		if not sprite_node.is_on_floor():
			if sprite_node.direction:
				sprite_node.velocity.x = move_toward(sprite_node.velocity.x, sprite_node.direction * sprite_node.MAX_SPEED, sprite_node.ACCELERATION * _delta)
			else:
				sprite_node.velocity.x = move_toward(sprite_node.velocity.x, 0, sprite_node.AIR_DECELERATION * _delta)
		else:
			transitioned.emit(self, 'PlayerIdle')
		
