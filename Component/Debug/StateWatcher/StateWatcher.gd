extends Node2D
@export var state_mechine_node:StateMechine
@export var sprite_node:Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$StateLabel.text = str(state_mechine_node.current_state.name) if state_mechine_node.current_state else ""
	if sprite_node is Player:
		$StateLabel2.text = str(sprite_node.player_state)
	else:
		$StateLabel2.text = ''
	pass
