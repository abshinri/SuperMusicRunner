class_name PiranhaStateMechine extends StateMechine

func _ready() -> void:
	super._ready()
	initial_state = states.get(get_state_name_by_enum(sprite_node.current_state).to_lower())
	initial_state.enter()
	current_state = initial_state
	

func _process(_delta: float) -> void:
	super._process(_delta)
	
func _physics_process(_delta: float) -> void:
	super._physics_process(_delta)
	# _on_child_transition(current_state, get_state_name_by_enum(sprite_node.current_state))
	# print(current_state, get_state_name_by_enum(sprite_node.current_state))
	
func get_state_name_by_enum(state:int) -> String:
	match state:
		sprite_node.StateEnum.PiranhaDefault:
			return "PiranhaDefault"
		sprite_node.StateEnum.PiranhaWalk:
			return "PiranhaWalk"
		sprite_node.StateEnum.PiranhaGetDown:
			return "PiranhaGetDown"
		sprite_node.StateEnum.PiranhaGetUp:
			return "PiranhaGetUp"
		sprite_node.StateEnum.PiranhaDance:
			return "PiranhaDance"
		_:
			return "PiranhaDefault"
		
