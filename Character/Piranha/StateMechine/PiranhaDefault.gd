class_name PiranhaDefault extends State

func enter() -> void:
	super.enter()
	sprite_node.current_state = sprite_node.StateEnum.PiranhaDefault
	animation_player.play(('Under' if sprite_node.piranha_is_under else 'Ground') + "Default")
	
func physics_update(_delta) -> void:
	super.physics_update(_delta)

