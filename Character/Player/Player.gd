class_name Player extends CharacterBody2D

## 最大速度
@export var MAX_SPEED:float = 250.0
## 走路速度阈值
@export var WALK_THRESHOLD:float = 0.5
## 刹车速度阈值
@export var BRAKE_THRESHOLD:float = 0.5
## 加速度
@export var ACCELERATION:float = 400.0
## 空中加速度
@export var AIR_ACCELERATION:float = 200.0
## 地面减速度
@export var DECELERATION:float = 800.0
## 空中减速度
@export var AIR_DECELERATION:float = 150.0
## 跳跃加速度
@export var JUMP_VELOCITY:float = -400.0
## 最低小跳(越大越小)
@export var JUMP_CUT:float = -280.0
## 方向
var direction:float
## 重力
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const dance_shader = preload ("res://Shader/Swing.gdshader")

var player_state := Enum.PlayerState.SMALL
var game_state := 'gaming' # or victory
var player_is_squat := false

@onready var jump_buff_detector := $JumpBuffDetector as RayCast2D

func _ready() -> void:
	SignalBank.start_dance.connect(func():
		var sprite2D = get_node('Sprite2D')
		sprite2D.material.set_shader_parameter('strength', 1.)
		sprite2D.get_node('FlyingNotes').emitting = true
		)

## 控制碰撞情况
func _handle_movement_collision(_collision: KinematicCollision2D):
	var _collider = _collision.get_collider()
	# 碰到敌人的情况
	if  Global.is_enemy(_collider):
		if _collider is Piranha:
			hurt()
		elif _collider.global_position.y < global_position.y:
			hurt()

func _physics_process(_delta):
	var collision = get_last_slide_collision()
	if collision != null:
		_handle_movement_collision(collision)

	if Input.is_action_just_pressed("move_down"):
		player_is_squat = true
		DECELERATION = 400
	if Input.is_action_just_released("move_down"):
		player_is_squat = false
		DECELERATION = 800
		
	direction = Input.get_axis("move_left", "move_right")
	velocity.y += gravity * _delta
	
	if game_state == 'victory':
		velocity.x = 0
	
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	elif velocity.x > 0:
		$Sprite2D.flip_h = false
	
		
	move_and_slide()


func hurt() -> void:
	if player_state == Enum.PlayerState.SMALL:
		die()
	elif player_state == Enum.PlayerState.BIG:
		grow_down()
	pass


func victory() -> void:
	game_state = 'victory()'
	pass

func die() -> void:
	player_state = Enum.PlayerState.DEAD
	pass

func grow_up() ->void:
	player_state = Enum.PlayerState.GROWING
	pass


func grow_down() ->void:
	player_state = Enum.PlayerState.SHRINKING
	pass
