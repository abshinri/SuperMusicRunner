class_name Shell extends MoveableObject

func _physics_process(_delta: float) -> void:
	super._physics_update(_delta)

var _is_running = false;

func _ready() -> void:
	$Area2D.body_entered.connect(_handle_collision)

func _handle_collision(body: Node2D):
	if body is Player:
		if !_is_running:
			#计算碰撞的位置, 偏左往右跑, 偏右往左跑
			var collision_position = body.global_position
			var shell_position = global_position
			var direction = 1
			if collision_position.x > shell_position.x:
				direction = -1
			#加速度
			move_speed = 200 * direction
			state = Enum.EnemyState.WALKING
			_is_running = true
		else:
			#如果是在跑, body位置在本节点左右和下方时被碰撞触发body的die
			if (body.global_position.x < global_position.x - 8  or body.global_position.x > global_position.x + 8) and body.global_position.y > global_position.y - 2:
				body.hurt()
			else:
				body.velocity.y = -250
			die()
	else:
		if body.die:
			body.die()
			die()
	
