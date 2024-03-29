class_name Shell extends MoveableObject

func _physics_process(_delta: float) -> void:
	super._physics_update(_delta)

var _is_running = false;

func _ready() -> void:
	$Area2D.body_entered.connect(_handle_collision)

func _handle_collision(body: Node2D):
	print('_handle_collision')
	print(body)
	if body is Player:
		if !_is_running:
			print('collision !_is_running')
			#计算碰撞的位置, 偏左往右跑, 偏右往左跑
			var collision_position = body.global_position
			var shell_position = global_position
			var _direction = 1
			if collision_position.x < shell_position.x:
				_direction = -1
			#加速度
			move_speed = 200 * _direction
			state = Enum.EnemyState.WALKING
			SignalBank.play_se.emit('Kick')
			_is_running = true
		else:
			print('collision _is_running')
			#如果是在跑, body位置在本节点左右和下方时被碰撞触发body的die
			if (body.global_position.x < global_position.x - 8  or body.global_position.x > global_position.x + 8) and body.global_position.y > global_position.y - 2:
				body.hurt()
			else:
				body.velocity.y = -250
			die()
			SignalBank.play_se.emit('Kick')
	else:
		print('collision not player')
		if Global.is_enemy(body) and _is_running:
			body.die()
			die()
			SignalBank.play_se.emit('Kick')
