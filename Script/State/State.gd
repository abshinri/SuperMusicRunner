class_name State extends Node
@onready var state_mechine_node = get_parent()
@onready var sprite_node = state_mechine_node.sprite_node
@onready var animation_player = state_mechine_node.animation_player
signal transitioned

func enter():
	pass
	
func exit():
	pass
	
func update(_delta: float):
	pass
	
func physics_update(_delta: float):
	if sprite_node is Player:
		if sprite_node.game_state == 'victory':
			transitioned.emit(self, 'PlayerVictory')
		if sprite_node.player_state == Enum.PlayerState.DEAD:
			transitioned.emit(self, 'PlayerDead')		
		if sprite_node.player_state == Enum.PlayerState.GROWING:
			transitioned.emit(self, 'PlayerGrowUp')
		if sprite_node.player_state == Enum.PlayerState.SHRINKING:
			transitioned.emit(self, 'PlayerGrowDown')
	return
