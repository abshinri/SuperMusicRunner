extends Node
# FileReader
var file_reader_loaded_list := []

# MusicPlayer
var current_track := - 1

# Object Global.isEnemy()
func isEnemy(body : Node2D) -> bool:
    if body is Goomba:
        return true
    elif body is Koopa:
        return true
    else:
        return false

    