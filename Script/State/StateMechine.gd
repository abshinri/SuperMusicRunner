class_name StateMechine extends Node
@export var initial_state: State
@export var animation_player:AnimationPlayer
@export var sprite_node:Node2D

var states:Dictionary = {}
var current_state:State = null

func _ready():
	for child in get_children():
		# 判断child类型
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(_on_child_transition)
	if initial_state:
		initial_state.enter()
		current_state = initial_state
		
func _process(_delta: float) -> void:
	if current_state:
		current_state.update(_delta)
	pass

func _physics_process(_delta: float) -> void:
	if current_state:
		current_state.physics_update(_delta)
	pass

## 开始执行状态转变
func _on_child_transition(_state:State, _next_state_name:String) -> void:
	print("Transitioning from ", _state.name, " to ", _next_state_name)
	# 确保这次的转变是从 当前状态 到 下一个状态
	if _state != current_state:
		return
	# 从状态字典里找到要跳转的状态
	var _next_state = states.get(_next_state_name.to_lower())
	
	if !_next_state:
		return
	# 执行状态退出
	if current_state:
		current_state.exit()
		
	_next_state.enter()
	current_state = _next_state
	
