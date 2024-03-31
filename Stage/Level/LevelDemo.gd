extends Node2D
@onready var _Animation = $AnimationPlayer.get_animation('LevelShow').duplicate(true)

func _ready() -> void:
	# 宝贵的经验! 确保动画能重启后正常播放, 先复制资源在添加到新库里去播放
	var _lib = AnimationLibrary.new()
	_lib.add_animation('LevelShow', _Animation)
	$AnimationPlayer.add_animation_library('back', _lib)
	 
	SignalBank.music_player_played.connect(func():
		await get_tree().create_timer(Global.show_delay).timeout
		$AnimationPlayer.play('back/LevelShow')
		print($AnimationPlayer.libraries)
		)
	pass # Replace with function body.

func game_start():
	SignalBank.game_start.emit()

func disable_animation_track(track_names: Array) -> void:
	var _anim = $AnimationPlayer.get_animation('back/LevelShow')
	for track_name in track_names:
		_anim.track_set_enabled(_anim.find_track(track_name, 0), false)

func play_se(se_name:String) -> void:
	SignalBank.play_se.emit(se_name)
