class_name State extends Node
@onready var state_mechine_node = get_parent()
@onready var sprite_node = state_mechine_node.sprite_node
@onready var animation_player = state_mechine_node.animation_player
signal transitioned

func enter():
	var collisionShape2D = sprite_node.get_node('CollisionShape2D')
	#if sprite_node.player_state == Enum.PlayerState.BIG:
		#if sprite_node.player_is_squat:
			#collisionShape2D.shape.size.y = 15
			#collisionShape2D.position.y = -7.5
		#else:
			#collisionShape2D.shape.size.y = 30
			#collisionShape2D.position.y = -10.0 
	#else:
		#collisionShape2D.shape.size.y = 15
		#collisionShape2D.position.y = -7.5

	pass
	
func exit():
	pass
	
func update(_delta: float):
	pass
	
func physics_update(_delta: float):
	if sprite_node.player_state == Enum.PlayerState.DEAD:
		transitioned.emit(self, 'PlayerDead')		
	if sprite_node.player_state == Enum.PlayerState.GROWING:
		transitioned.emit(self, 'PlayerGrowUp')
	if sprite_node.player_state == Enum.PlayerState.SHRINKING:
		transitioned.emit(self, 'PlayerGrowDown')
	return
