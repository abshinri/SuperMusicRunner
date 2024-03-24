class_name Piranha extends CharacterBody2D

@export var move_speed: float = 20
## 重力
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var piranha_state := Enum.PiranhaState.DEFAULT
@export var piranha_is_under := true

var is_on_wall_cool_down = false
func _physics_process(_delta):
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	elif velocity.x > 0:
		$Sprite2D.flip_h = false
	velocity.y += gravity * _delta
	if is_on_wall():
		if not is_on_wall_cool_down:
			is_on_wall_cool_down = true
			move_speed = -move_speed
			await get_tree().create_timer(0.5).timeout
			is_on_wall_cool_down = false
	move_and_slide()
