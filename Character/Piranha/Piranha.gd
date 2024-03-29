class_name Piranha extends CharacterBody2D

enum StateEnum {PiranhaDefault, PiranhaWalk, PiranhaGetDown, PiranhaGetUp, PiranhaDance}

@export var move_speed: float = 20
@export var direction := - 1
@export var upsidedown := false
@export var piranha_is_under := true
@export var current_state: StateEnum = StateEnum.PiranhaDefault:
			get:
				return current_state
			set(value):
				if current_state == value:
					return
				current_state = value
				if $PiranhaStateMechine.current_state != null:
					$PiranhaStateMechine._on_child_transition($PiranhaStateMechine.current_state, get_state_name_by_enum(current_state))

@export var flying_notes_emitter := false:
			get:
				return flying_notes_emitter
			set(value):
				$Sprite2D/FlyingNotes.emitting = value
@export var alive := true:
			get:
				return alive
			set(value):
				alive = value
				if not alive:
					queue_free()
## 无形的
@export var invisible := true:
			get:
				return invisible
			set(value):
				if value:
					set_collision_mask_value(5, false)
				else:
					set_collision_mask_value(5, true)
				invisible = value

## 重力
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_on_wall_cool_down = false

var _upsidedown = 1
func _ready() -> void:
	SignalBank.start_dance.connect(Callable(self, '_on_start_dance'))
	if upsidedown:
		$Sprite2D.flip_v = true
		_upsidedown = -1

func _physics_process(_delta):
	if piranha_is_under or current_state == StateEnum.PiranhaDance or current_state == StateEnum.PiranhaGetDown or current_state == StateEnum.PiranhaGetUp:
		velocity.x = 0
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	elif velocity.x > 0:
		$Sprite2D.flip_h = false
	if !invisible and !piranha_is_under:
		velocity.y += gravity * _delta * _upsidedown
	# if is_on_wall():
	# 	if not is_on_wall_cool_down:
	# 		is_on_wall_cool_down = true
	# 		move_speed = -move_speed * direction
	# 		await get_tree().create_timer(0.5).timeout
	# 		is_on_wall_cool_down = false
	move_and_slide()

func _on_start_dance() -> void:
	flying_notes_emitter = true

func back_to_pip() -> void:
	var upsidedown_direction = -1 if !upsidedown else 1
	current_state = StateEnum.PiranhaGetDown
	await get_tree().create_timer(0.7).timeout
	piranha_is_under = true
	current_state = StateEnum.PiranhaDefault
	invisible = true
	var tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(0, -32 * upsidedown_direction), .1)
	await tween.finished
	alive = false

func get_state_name_by_enum(state: int) -> String:
	match state:
		StateEnum.PiranhaDefault:
			return "PiranhaDefault"
		StateEnum.PiranhaWalk:
			return "PiranhaWalk"
		StateEnum.PiranhaGetDown:
			return "PiranhaGetDown"
		StateEnum.PiranhaGetUp:
			return "PiranhaGetUp"
		StateEnum.PiranhaDance:
			return "PiranhaDance"
		_:
			return "PiranhaDefault"
