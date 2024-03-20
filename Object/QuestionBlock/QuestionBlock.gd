class_name QuestionBlock extends StaticObject

enum Type {
	SINGLE_COIN = 1,
	MUTLPLE_COIN = 2,
	MUSHROOM = 3,
	OFF = 4
}

@export var type: Type = Type.SINGLE_COIN
var _item:PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if type == Type.MUSHROOM:
		_item = preload("res://Object/Mushroom/Mushroom.tscn")
	
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	super._physics_process(_delta)
	pass

func _generate_tween(_target) -> bool:
	var tween = create_tween()
	tween.tween_property(_target, "position", position + Vector2(0, -24), .16)
	await tween.finished
	return true

func _generat_mushroom() -> void:
	var mushroom = _item.instantiate()
	mushroom.position = position
	await _generate_tween(mushroom)
	mushroom.state = Enum.ItemState.GENERATING
	get_parent().add_child(mushroom)
	mushroom.state = Enum.ItemState.WALKING

var _bumping := false
func bump(_state: String) -> void:
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
	if type == Type.MUSHROOM:
		_generat_mushroom()

	await bump_tween.finished
	_bumping = false
