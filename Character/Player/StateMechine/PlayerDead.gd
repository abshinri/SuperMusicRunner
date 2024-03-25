class_name PlayerDead extends State

func enter() -> void:
	super.enter()
	SignalBank.play_se.emit('Die')
	animation_player.play("Dead")
	sprite_node.set_collision_mask_value(2, false)
	sprite_node.set_collision_layer_value(2, false)
	sprite_node.set_physics_process(false)
	await animation_player.animation_finished
	sprite_node.queue_free()
	
func physics_update(_delta) -> void:
	super.physics_update(_delta)
