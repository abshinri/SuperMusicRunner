class_name Piranha extends CharacterBody2D

enum StateEnum {PiranhaDefault,PiranhaWalk,PiranhaGetDown,PiranhaGetUp,PiranhaDance}


@export var move_speed: float = 20
@export var direction := -1
@export var upsidedown := false
@export var piranha_is_under := true
@export var current_state:StateEnum = StateEnum.PiranhaDefault
## 重力
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var piranha_state := Enum.PiranhaState.DEFAULT

var is_on_wall_cool_down = false

var _upsidedown = 1
func _ready() -> void:
	SignalBank.start_dance.connect(Callable(self,'_on_start_dance'))
	if upsidedown:
		$Sprite2D.flip_p = true
		_upsidedown = -1

func _physics_process(_delta):
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	elif velocity.x > 0:
		$Sprite2D.flip_h = false
	velocity.y += gravity * _delta * _upsidedown
	if is_on_wall():
		if not is_on_wall_cool_down:
			is_on_wall_cool_down = true
			move_speed = -move_speed * direction
			await get_tree().create_timer(0.5).timeout
			is_on_wall_cool_down = false
	move_and_slide()

func _on_start_dance() -> void:
	$Sprite2D/FlyingNotes.emitting = true
	

