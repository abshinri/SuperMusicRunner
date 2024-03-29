class_name Game extends Node2D

var SEDict = {
	'1up': load("res://Asset/Audio/1up.wav"),
	'Beep': load("res://Asset/Audio/Beep.wav"),
	'BigJump': load("res://Asset/Audio/Big Jump.wav"),
	'BowserDie': load("res://Asset/Audio/Bowser Die.wav"),
	'Break': load("res://Asset/Audio/Break.wav"),
	'Bump': load("res://Asset/Audio/Bump.wav"),
	'Coin': load("res://Asset/Audio/Coin.wav"),
	'Die': load("res://Asset/Audio/Die.wav"),
	'EnemyFire': load("res://Asset/Audio/Enemy Fire.wav"),
	'FireBall': load("res://Asset/Audio/Fire Ball.wav"),
	'Flagpole': load("res://Asset/Audio/Flagpole.wav"),
	'GameOver': load("res://Asset/Audio/Game Over.wav"),
	'Item': load("res://Asset/Audio/Item.wav"),
	'Jump': load("res://Asset/Audio/Jump.wav"),
	'Kick': load("res://Asset/Audio/Kick.wav"),
	'Pause': load("res://Asset/Audio/Pause.wav"),
	'Powerup': load("res://Asset/Audio/Powerup.wav"),
	'Skid': load("res://Asset/Audio/Skid.wav"),
	'Squish': load("res://Asset/Audio/Squish.wav"),
	'Thwomp': load("res://Asset/Audio/Thwomp.wav"),
	'Vine': load("res://Asset/Audio/Vine.wav"),
	'Warp': load("res://Asset/Audio/Warp.wav"),
}

func _ready():
	SignalBank.play_se.connect(Callable(self, '_play_se'))
	pass # Replace with func
var se = AudioStreamPlayer.new()
func _play_se(type):
	se.stream = SEDict[type]
	
	add_child(se)
	se.play()
		
	#await se.finished
	#se.queue_free()
	#pass


# func _play_se(type, loop: bool, _callback: Callable):

# 	var se = AudioStreamPlayer.new()
# 	se.stream = SEDict[type]
	
# 	if loop:
# 		se.stream.loop_mode = 1
# 		se.stream.loop_begin = 0
# 		se.stream.loop_end = -1

# 		add_child(se)
# 		se.play()
		
# 		_callback.call(se)
# 	else:
# 		add_child(se)
# 		se.play()

# 		await se.finished
# 		se.queue_free()
	
# 	pass
