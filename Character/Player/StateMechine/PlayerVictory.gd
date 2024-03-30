class_name PlayerVictory extends State

func enter() -> void:
	super.enter()
	animation_player.play(sprite_node.player_state + "Victory")
	await get_tree().create_timer(6.2).timeout
	SignalBank.game_over.emit()
	
func physics_update(_delta) -> void:
	super.physics_update(_delta)
