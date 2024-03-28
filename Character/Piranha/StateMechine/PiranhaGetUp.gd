class_name PiranhaGetUp extends State
var flying_dust:Node2D
func enter() -> void:
	flying_dust = sprite_node.get_node('Sprite2D/FlyingDust')
	if !sprite_node.piranha_is_under:
		# transitioned.emit(self, 'PiranhaDance')
		sprite_node.current_state = sprite_node.StateEnum.PiranhaDance
	else:
		super.enter()
		flying_dust.emitting = true
		animation_player.play(('Under' if sprite_node.piranha_is_under else 'Ground') + "GetUp")
		sprite_node.piranha_is_under = false
		print(('Under' if sprite_node.piranha_is_under else 'Ground') + "GetUp")
		await animation_player.animation_finished

		# transitioned.emit(self, 'PiranhaDance')
		sprite_node.current_state = sprite_node.StateEnum.PiranhaDance
		
func exit() -> void:
	flying_dust.emitting = false
	
func physics_update(_delta) -> void:
	super.physics_update(_delta)

