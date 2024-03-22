class_name PlayerGrowDown extends State

var _freeze = false

func enter() -> void:
	super.enter()
	_freeze = true
	animation_player.play("GrowDown")
	
	# #关闭重力
	sprite_node.set_physics_process(false)
	await animation_player.animation_finished
	_freeze = false
	sprite_node.set_physics_process(true)
	transitioned.emit(self, 'PlayerIdle')

func exit() -> void:
	super.exit()
	sprite_node.player_state = Enum.PlayerState.SMALL

func physics_update(_delta) -> void:
	if !_freeze:
		super.physics_update(_delta)
