class_name Player extends CharacterBody2D

## 最大速度
@export var MAX_SPEED:float = 300.0
## 走路速度阈值
@export var WALK_THRESHOLD:float = 0.5
## 刹车速度阈值
@export var BRAKE_THRESHOLD:float = 0.6
## 加速度
@export var ACCELERATION:float = 300.0
## 加速度
@export var AIR_ACCELERATION:float = 200.0
## 地面减速度
@export var DECELERATION:float = 800.0
## 空中减速度
@export var AIR_DECELERATION:float = 150.0
## 跳跃加速度
@export var JUMP_VELOCITY:float = -400.0
## 跳跃减速度
@export var JUMP_CUT:float = -200.0
## 方向
var direction:float
## 重力
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var player_state = Enum.PlayerState.SMALL

@onready var jump_buff_detector := $JumpBuffDetector as RayCast2D

func _physics_process(delta):
	direction = Input.get_axis("move_left", "move_right")
	velocity.y += gravity * delta
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	elif velocity.x > 0:
		$Sprite2D.flip_h = false
		
	move_and_slide()

func grow_up() ->void:
	player_state = Enum.PlayerState.GROWING
	pass
