class_name Movable extends AnimatableBody2D

signal move_state_changed(_move: bool, _speed: float)
var _move_state := false
var _move_speed := 1.0

func _ready() -> void:
	move_state_changed.connect(Callable(self, '_on_move_state_changed'))
	_on_move_state_changed(true, 1.0)

func _physics_process(_delta: float) -> void:
	if _move_state:
		position.x -= _move_speed

func _on_move_state_changed(_move: bool, _speed: float) -> void:
	_move_speed = _speed
	_move_state = _move
