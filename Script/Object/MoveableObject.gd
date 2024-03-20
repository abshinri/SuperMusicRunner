class_name MoveableObject extends CharacterBody2D

enum ObjectType {
	ITEM, ENEMY
}

@export var can_fall:=false
@export var move_speed:= 20
@export var object_type := ObjectType.ITEM

@onready var gravity: int = ProjectSettings.get("physics/2d/default_gravity")


var state
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if object_type == ObjectType.ITEM:
		state = Enum.ItemState.WALKING
	else:
		state = Enum.EnemyState.WALKING
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_update(_delta: float) -> void:
	if (state == Enum.ItemState.WALKING or state == Enum.EnemyState.WALKING) and velocity.is_zero_approx():
		velocity.x = move_speed
	velocity.y += gravity * _delta

	#if not floor_detector_left.is_colliding():
		#velocity.x = WALK_SPEED
	#elif not floor_detector_right.is_colliding():
		#velocity.x = -WALK_SPEED
	if is_on_wall():
		velocity.x = -velocity.x
	move_and_slide()
	pass
