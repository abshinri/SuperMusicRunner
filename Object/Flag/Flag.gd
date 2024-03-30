extends Sprite2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.game_state = 'victory'
		SignalBank.play_se.emit('StageClear')
		$GPUParticles2D.emitting = true
