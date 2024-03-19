class_name ObjectGenerator extends Node2D
@export var game: Game
@export var music_player: MusicPlayer


var _current_fft: Array = []
var _current_music_inf:Dictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBank.music_player_played.connect(_on_music_player_played)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_music_player_played() -> void:
	_current_music_inf = music_player.get_music_info()
	_current_fft = music_player.get_fft()
	pass
