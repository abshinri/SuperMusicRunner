extends Node
# FileReader
signal file_reader_loaded()

# MusicPlayer
signal mucis_player_loaded()
signal music_player_played()
signal music_player_finished()

# SEPlayer
signal play_se(type)
signal stop_se(se)

# Stage
signal start_dance()
signal game_start()
signal game_over()
