class_name PlayerGrowUp extends State

var _freeze = false
func enter() -> void:
	super.enter()
	_freeze = true
	animation_player.play("GrowUp")

	# #关闭重力
	#暂时清空速度
	var current_velocity = sprite_node.velocity

	await animation_player.animation_finished
	transitioned.emit(self, 'PlayerIdle')
	_freeze = false
	
	sprite_node.velocity = current_velocity
	# sprite_node.move_and_collide(current_velocity, false)

func exit() -> void:
	super.exit()
	sprite_node.player_state = Enum.PlayerState.BIG

func physics_update(_delta) -> void:
	if _freeze:
		sprite_node.velocity = Vector2(0, 0)
		# sprite_node.move_and_collide(Vector2(0, 0), true)
		return
	else:
		super.physics_update(_delta)
