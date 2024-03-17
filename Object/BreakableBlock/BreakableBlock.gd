class_name BreakableBlock extends Movable

@export var type := 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var graphics = $Graphic.get_children()
	for child in graphics:
		child.visible = false
	graphics[type-1].visible = true
	
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	super._physics_process(_delta)
	pass

var _bumping := false
func bump(_state:String) -> void:
	if _bumping: 
		return
	_bumping = true
	var bump_tween = create_tween()
	bump_tween.tween_property(self, "position", position + Vector2(0, -4), .12)
	bump_tween.chain().tween_property(self, "position", position, .12)
	await bump_tween.finished
	_bumping = false
