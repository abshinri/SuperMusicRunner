extends Node2D
@export var state_mechine_node:StateMechine
@export var sprite_node:Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$StateLabel.text = str(state_mechine_node.current_state.name) if state_mechine_node.current_state else ""
	pass
