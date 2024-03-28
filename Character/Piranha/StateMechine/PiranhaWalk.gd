class_name PiranhaWalk extends State

func enter() -> void:
	print("PiranhaWalk enter")
	print(sprite_node.piranha_is_under)
	if sprite_node.piranha_is_under:
		# transitioned.emit(self, 'PiranhaDance')
		sprite_node.current_state = sprite_node.StateEnum.PiranhaDance
	else:
		super.enter()
		# sprite_node.current_state = sprite_node.StateEnum.PiranhaWalk
		animation_player.play(('Under' if sprite_node.piranha_is_under else 'Ground') + "Walk")
	
func physics_update(_delta) -> void:
	super.physics_update(_delta)

	if !sprite_node.piranha_is_under or sprite_node.just_stop_h:
		sprite_node.velocity.x = sprite_node.move_speed * sprite_node.direction
