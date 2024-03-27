extends Camera2D

var level_start = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBank.game_start.connect(func():level_start = true)
	SignalBank.music_player_played.connect(_start_level)
	
	pass # Replace with function body.
var rolling_length = 1960 - 384
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if level_start:
		self.position.x += 35 * delta
		if self.position.x >= rolling_length:
			self.position.x = rolling_length
			level_start = false
	pass

func _start_level():
	SignalBank.start_dance.emit()
