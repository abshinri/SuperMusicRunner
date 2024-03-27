extends Node
# FileReader
var file_reader_loaded_list := []

# MusicPlayer
var current_track := - 1

# Object Global.is_enemy()
func is_enemy(body : Node2D) -> bool:
	if body is Goomba:
		return true
	elif body is Koopa:
		return true
	elif body is Piranha:
		return true
	else:
		return false

	
