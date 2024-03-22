class_name StaticObject extends AnimatableBody2D

func _physics_process(_delta: float) -> void:
	_on_CrashZone_body_entered()

## 如果节点存在BumpDetector, 则在触发时Bump是调用这个, 让敌人受击物体弹起
func _on_BumpDetector_body_entered() -> void:
	if get_node('BumpDetector'):
		var _overlaps_body = get_node('BumpDetector').get_overlapping_bodies()
		for node in _overlaps_body:
			if node.name == 'Mushroom':
				node.bump()
			if Global.isEnemy(node):
				print('enemy')
				node.die()

## 检查CrashZone是否同时碰到Crash边界和玩家
func _on_CrashZone_body_entered() -> void:
	if get_node('CrashZone'):
		var _overlaps_body = get_node('CrashZone').get_overlapping_bodies()
		if _overlaps_body.size() > 1:
			# 遍历_overlaps_body, 如果同时有两个节点名字为Player和BlockPlayerZone, 则触发信号
			var player_found = false
			var block_found = false
			var _player: Player
			for node in _overlaps_body:
				if node.name == 'Player':
					player_found = true
					_player = node
				elif node.name == 'BlockPlayerZone':
					block_found = true
			if player_found and block_found:
				_player.player_state = Enum.PlayerState.DEAD
