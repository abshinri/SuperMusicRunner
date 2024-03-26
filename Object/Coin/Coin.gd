class_name Coin extends MoveableObject

func _physics_process(_delta: float) -> void:
	if !_bumping:
		super._physics_update(_delta, true)

var _bumping := false
func bump() -> void:
	if _bumping: 
		return
	_bumping = true
	var bump_tween = create_tween()
	bump_tween.tween_property(self, "position", position + Vector2(0, -16), 1)
	await bump_tween.finished
	queue_free()
	_bumping = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and _bumping == false:
		SignalBank.play_se.emit('Coin')
		queue_free()
	pass # Replace with function body.
