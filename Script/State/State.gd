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
	pass
