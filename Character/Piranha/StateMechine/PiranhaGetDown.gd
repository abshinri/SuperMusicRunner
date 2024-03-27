class_name PiranhaGetDown extends State

func enter() -> void:
	if sprite_node.piranha_is_under:
		transitioned.emit(self, 'PiranhaDance')
	else:
		super.enter()
		sprite_node.current_state = sprite_node.StateEnum.PiranhaGetDown
		animation_player.play(('Under' if sprite_node.piranha_is_under else 'Ground') + "GetDown")
		await animation_player.animation_finished
		sprite_node.piranha_is_under = false
		transitioned.emit(self, 'PiranhaDance')
	
func physics_update(_delta) -> void:
	super.physics_update(_delta)

