class_name UnbreakableBlock extends StaticObject

enum Type {
	STONE = 1,
	FLOOR = 2,
}

@export var type: Type = Type.STONE

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
	_bumping = false
	# playsound
