class_name MovableObject extends AnimatableBody2D

signal move_state_changed(_move: Enum.MovableObjectState, _speed: float)
@export var _move_state: Enum.MovableObjectState = Enum.MovableObjectState.IDLE
@export var _move_speed := 1.0

func _ready() -> void:
	move_state_changed.connect(Callable(self, '_on_move_state_changed'))
	_on_move_state_changed(Enum.MovableObjectState.MOVE, 1.0)

func _physics_process(_delta: float) -> void:
	if _move_state == Enum.MovableObjectState.MOVE:
		position.x -= _move_speed
	_on_CrashZone_body_entered()

func _on_move_state_changed(_move: Enum.MovableObjectState, _speed: float) -> void:
	_move_speed = _speed
	_move_state = _move

## 检查CrashZone是否同时碰到Crash边界和玩家
func _on_CrashZone_body_entered() -> void:
	if get_node('CrashZone'):
		var node_overlapping = get_node('CrashZone').get_overlapping_bodies()
		if node_overlapping.size() > 1:
			# 遍历node_overlapping, 如果同时有两个节点名字为Player和BlockPlayerZone, 则触发信号
			var player_found = false
			var block_found = false
			var player = null
			for node in node_overlapping:
				if node.name == 'Player':
					player_found = true
					player = node
				elif node.name == 'BlockPlayerZone':
					block_found = true
			if player_found and block_found:
				player.player_state = Enum.PlayerState.DEAD
