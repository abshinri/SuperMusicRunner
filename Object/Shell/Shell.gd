class_name Shell extends MoveableObject

func _physics_process(_delta: float) -> void:
	if !_bumping:
		super._physics_update(_delta)

var _bumping := false
func bump() -> void:
	if _bumping: 
		return
	_bumping = true
	velocity.x = -velocity.x
	var bump_tween = create_tween()
	bump_tween.tween_property(self, "position", position + Vector2(0, -4), .12)
	await bump_tween.finished
	_bumping = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if body.player_state == Enum.PlayerState.SMALL:
			body.grow_up()
		queue_free()
	pass # Replace with function body.
