class_name QuestionBlock extends StaticObject

enum Type {
	COIN = 1,
	MUSHROOM = 2,
	OFF = 3
}

@export var type: Type = Type.COIN
## 只有在MUTLPLE_COIN才有效
@export var coin_number = 1
var _item:PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if type == Type.MUSHROOM:
		_item = preload("res://Object/Mushroom/Mushroom.tscn")
	if type == Type.COIN:
		_item = preload("res://Object/Coin/Coin.tscn")
	
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	super._physics_process(_delta)
	pass
func _generate_tween(_target, _y := -24) -> bool:
	var tween = create_tween()
	tween.tween_property(_target, "position", position + Vector2(0, _y), .16)
	await tween.finished
	return true

func _generat_mushroom() -> void:
	var mushroom = _item.instantiate()
	mushroom.position = position
	await _generate_tween(mushroom)
	mushroom.state = Enum.ItemState.GENERATING
	get_parent().add_child(mushroom)
	mushroom.state = Enum.ItemState.WALKING

func _generate_coin() -> void:
	coin_number -= 1
	var coin = _item.instantiate()
	coin.position = position
	await _generate_tween(coin, -16)
	coin.state = Enum.ItemState.GENERATING
	get_parent().add_child(coin)
	coin.state = Enum.ItemState.IDLE
	coin.bump()

func _handle_bump_top_collision(_collision: KinematicCollision2D) -> void:
	pass

var _bumping := false
func bump(_state: String) -> void:
	if !$Graphic/Type1.visible:
		return

	if _bumping: 
		return
	_bumping = true
	_on_BumpDetector_body_entered()
	if type == Type.MUSHROOM or (type == Type.COIN and coin_number < 1):
		$Graphic/Type1.visible = false
		$Graphic/Type2.visible = true

	var bump_tween = create_tween()
	bump_tween.tween_property(self, "position", position + Vector2(0, -4), .12)
	bump_tween.chain().tween_property(self, "position", position, .12)
	if type == Type.MUSHROOM:
		_generat_mushroom()
	if type == Type.COIN:
		_generate_coin()

	await bump_tween.finished
	_bumping = false
