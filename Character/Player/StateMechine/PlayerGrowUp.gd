class_name PlayerGrowUp extends State

var _freeze = false

func enter() -> void:
	super.enter()
	# #关闭重力
	sprite_node.set_physics_process(false)
	SignalBank.play_se.emit('Powerup')
	animation_player.play("GrowUp")
	
	await get_tree().create_timer(0.6).timeout
	sprite_node.set_physics_process(true)
	_freeze = false
	transitioned.emit(self, 'PlayerIdle')

func exit() -> void:
	super.exit()
	sprite_node.player_state = Enum.PlayerState.BIG

func physics_update(_delta) -> void:
	if !_freeze:
		super.physics_update(_delta)
