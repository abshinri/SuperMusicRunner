class_name PlayerGrowUp extends State

var _freeze = false

func enter() -> void:
	super.enter()
	_freeze = true
	animation_player.play("GrowUp")
	
	# #关闭重力
	sprite_node.set_physics_process(false)
	await animation_player.animation_finished
	transitioned.emit(self, 'PlayerIdle')
	_freeze = false
	sprite_node.set_physics_process(true)

func exit() -> void:
	super.exit()
	sprite_node.player_state = Enum.PlayerState.BIG

func physics_update(_delta) -> void:
	if !_freeze:
		super.physics_update(_delta)
