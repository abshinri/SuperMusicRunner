extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = 4
	hide()
	SignalBank.game_over.connect(_open_restart)
	pass # Replace with function body.

func _input(event) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			_restart()

func _open_restart() -> void:
	process_mode = 0 # = Mode: Inherit
	show()
	pass
	
func _restart() -> void:
	get_tree().reload_current_scene()
	pass
