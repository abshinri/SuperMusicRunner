extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print('_on_body_entered')
	await get_tree().create_timer(3).timeout
	if body != null:
		body.queue_free()
	pass # Replace with function body.
