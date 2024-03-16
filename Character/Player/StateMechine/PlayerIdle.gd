class_name PlayerIdle extends State

func enter() -> void:
	animation_player.play("idle")
	
func update(_delta) -> void:
	if not sprite_node.is_on_floor():
		transitioned.emit(self,'PlayerJump')
	if sprite_node.direction:
		transitioned.emit(self,'PlayerWalk')
	if Input.is_action_just_pressed("move_jump") and sprite_node.is_on_floor():
		sprite_node.velocity.y = sprite_node.JUMP_VELOCITY
		transitioned.emit(self, 'PlayerJump')
