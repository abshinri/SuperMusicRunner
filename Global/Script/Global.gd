extends Node
# FileReader
var file_reader_loaded_list := []

# MusicPlayer
var play_delay := 1.8
var show_delay := 0

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

	
