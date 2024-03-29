class_name Pip extends StaticObject

enum Type {EMPTY, ITEM, ENEMY, FAKE}

@export var type: Type = Type.EMPTY
@export var item: String = ""
@export var enemy: String = ""
@export var pip_height: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var add_num = 0
	if pip_height > 1:
		for i in range(1, pip_height):
			add_num += 1
			var pip = $Body.duplicate()
			pip.position = Vector2(0, i * 16 )
			add_child(pip)
		## 增加高度
		#$CrashZone/CollisionShape2D.shape.size.y += add_num * 16
		#$CollisionShape2D.shape.size.y += add_num * 16		

		$CrashZone/CollisionShape2D.apply_scale(Vector2(1., add_num * 0.5 + 1))
		$CollisionShape2D.apply_scale(Vector2(1., add_num * 0.5 + 1))
		
		$CrashZone/CollisionShape2D.position.y += add_num * 8
		$CollisionShape2D.position.y += add_num * 8
		
	if type != Type.FAKE:
		if scale.x > 1:
			$CrashZone/CollisionShape2D.apply_scale(Vector2((1 / scale.x), 1))
			$CrashZone/CollisionShape2D.position.x += ($CrashZone/CollisionShape2D.shape.get_rect().size.x / 4)
	else:
		$CollisionShape2D.disabled = true
		$CrashZone/CollisionShape2D.disabled = true
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	super._physics_process(_delta)
	pass
