class_name BreakableBlock extends StaticObject

enum Type {
	BRICK1 = 1,
	BRICK2 = 2,
}

@export var type: Type = Type.BRICK1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var graphics = $Graphic.get_children()
	for child in graphics:
		child.visible = false
	graphics[type - 1].visible = true
	
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	super._physics_process(_delta)
	pass

var _bumping := false
func bump(_state: String) -> void:
	if _bumping:
		return
	_bumping = true
	_on_BumpDetector_body_entered()
	if _state != Enum.PlayerState.SMALL:
		SignalBank.play_se.emit('Break')
		$Graphic.visible = false
		$CollisionShape2D.disabled = true
	else:
		SignalBank.play_se.emit('Bump')
	var bump_tween = create_tween()
	bump_tween.tween_property(self, "position", position + Vector2(0, -4), .12)
	bump_tween.chain().tween_property(self, "position", position, .12)
	await bump_tween.finished
	if _state != Enum.PlayerState.SMALL:
		$Break.emitting = true
		await $Break.finished
		queue_free()
	_bumping = false

