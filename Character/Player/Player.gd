extends CharacterBody2D

## 最大速度
@export var MAX_SPEED:float = 300.0
## 走路速度阈值
@export var WALK_THRESHOLD:float = 0.5
## 刹车速度阈值
@export var BRAKE_THRESHOLD:float = 0.6
## 加速度
@export var ACCELERATION:float = 300.0
## 地面减速度
@export var DECELERATION:float = 800.0
## 空中减速度
@export var AIR_DECELERATION:float = 150.0
## 跳跃加速度
@export var JUMP_VELOCITY:float = -400.0
## 方向
var direction:float
## 重力
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#func _physics_process(delta):
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("move_jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("move_left", "move_right")
	#
	### 如果输入方向和当前速度方向相反，那么快速减速
	#if direction * velocity.x < 0:
		#velocity.x = move_toward(velocity.x, 0, DECELERATION * 2 * delta)
#
	#if direction:
		#velocity.x = move_toward(velocity.x, direction * MAX_SPEED, ACCELERATION * delta)
	#else:
		#velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)
		#
	#if is_on_floor():
		#if direction * velocity.x < 0 and abs(velocity.x) < BRAKE_THRESHOLD * MAX_SPEED:
			#print('stop')
			#$AnimationPlayer.play("stop")
		##移动速度为0时，播放静止动画
		#elif velocity.x == 0:
			#$AnimationPlayer.play("idle")
		##移动速度不为0时且移动速度低于走路速度阈值，播放走路动画
		#elif abs(velocity.x) < WALK_THRESHOLD * MAX_SPEED:
			#$AnimationPlayer.play("walk")
		#elif velocity.x != 0 and is_on_floor():
			#$AnimationPlayer.play("run")
	## 角色速度向左,则翻转角色
		#if velocity.x < 0:
			#$Sprite2D.flip_h = true
		#elif velocity.x > 0:
			#$Sprite2D.flip_h = false
	#else:
		#$AnimationPlayer.play("jump")
	#move_and_slide()
func _physics_process(delta):
	direction = Input.get_axis("move_left", "move_right")
	velocity.y += gravity * delta
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	elif velocity.x > 0:
		$Sprite2D.flip_h = false
		
	move_and_slide()
