class_name StaticObject extends AnimatableBody2D

func _physics_process(_delta: float) -> void:
	_on_CrashZone_body_entered()

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
