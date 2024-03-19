class_name QuestionBlock extends StaticObject

enum Type {
	SINGLE_COIN = 1,
	MUTLPLE_COIN = 2,
	MUSHROOM = 3,
	OFF = 4
}

@export var type: Type = Type.SINGLE_COIN

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	super._physics_process(_delta)
	pass

var _bumping := false
func bump(_state:Enum.PlayerState) -> void:
	if !$Graphic/Type1.visible:
		return
	if _bumping: 
		return
	_bumping = true
	$Graphic/Type1.visible = false
	$Graphic/Type2.visible = true
	var bump_tween = create_tween()
	bump_tween.tween_property(self, "position", position + Vector2(0, -4), .12)
	bump_tween.chain().tween_property(self, "position", position, .12)
	
	await bump_tween.finished
	_bumping = false
