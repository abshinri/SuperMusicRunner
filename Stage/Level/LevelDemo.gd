extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBank.music_player_played.connect(func():
		await get_tree().create_timer(Global.show_delay).timeout
		$AnimationPlayer.play('LevelShow')
		print($AnimationPlayer.libraries)
		)
	pass # Replace with function body.

func game_start():
	SignalBank.game_start.emit()

func disable_animation_track(track_names: Array) -> void:
	var _anim = $AnimationPlayer.get_animation('LevelShow')
	for track_name in track_names:
		_anim.track_set_enabled(_anim.find_track(track_name, 0), false)
