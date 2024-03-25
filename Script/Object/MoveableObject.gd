class_name MoveableObject extends CharacterBody2D

enum ObjectType {
	ITEM, ENEMY
}

@export var can_fall := false
@export var move_speed := 20
@export var object_type := ObjectType.ITEM
@export var direction := - 1
@onready var gravity: int = ProjectSettings.get("physics/2d/default_gravity")

var can_dance = true
var _debug_name = preload ("res://Component/Debug/ObjectName/ObjectName.tscn")
var state
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(_debug_name.instantiate())
	if object_type == ObjectType.ITEM:
		state = Enum.ItemState.WALKING
	else:
		state = Enum.EnemyState.WALKING
	pass # Replace with function body.

func _handle_movement_collision(_collision) -> void:
	var _collider = _collision.get_collider()
	if _collider is Player:
		_collider.hurt()
var is_on_wall_cool_down = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_update(_delta: float, _disable_y_gravity:=false) -> void:
	if object_type == ObjectType.ENEMY and state == Enum.EnemyState.DEAD:
		return
		
	if object_type == ObjectType.ENEMY:
		var collision = get_last_slide_collision()
		if collision != null:
			_handle_movement_collision(collision)

	if not (self is Mushroom): 
		if velocity.x < 0:
			$Sprite2D.flip_h = true
		elif velocity.x > 0:
			$Sprite2D.flip_h = false

	if ((state == Enum.ItemState.WALKING and object_type == ObjectType.ITEM) or (state == Enum.EnemyState.WALKING and object_type == ObjectType.ENEMY)) and velocity.is_zero_approx():
		velocity.x = move_speed * direction
	if !_disable_y_gravity:
		velocity.y += gravity * _delta

	#if not floor_detector_left.is_colliding():
		#velocity.x = WALK_SPEED
	#elif not floor_detector_right.is_colliding():
		#velocity.x = -WALK_SPEED
	if is_on_wall():
		if self is Shell:
			if not is_on_wall_cool_down:
				is_on_wall_cool_down = true
				SignalBank.play_se.emit('Bump')
				await get_tree().create_timer(0.5).timeout
				is_on_wall_cool_down = false
		move_speed = -move_speed
		
	move_and_slide()
	pass

func die(_stop:=false) -> void:
	if object_type == ObjectType.ITEM:
		return
	if _stop:
		velocity = Vector2(0, 0)
		state = Enum.EnemyState.DEAD
		
	velocity.y = -200
	# 随机自转一点方向
	rotation = randf_range( - 1., 1.)
	set_collision_mask_value(2, false)
	set_collision_mask_value(5, false)
	set_collision_layer_value(4, false)
	await get_tree().create_timer(1.0).timeout
	queue_free()
	pass
