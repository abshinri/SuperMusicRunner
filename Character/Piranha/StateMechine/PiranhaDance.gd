class_name PiranhaDance extends State

func enter() -> void:
	super.enter()
	# sprite_node.current_state = sprite_node.StateEnum.PiranhaDance
	animation_player.play(('Under' if sprite_node.piranha_is_under else 'Ground') + "Dance")
	
func physics_update(_delta) -> void:
	super.physics_update(_delta)

