extends Node2D

const dance_shader = preload ("res://Shader/Swing.gdshader")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 遍历所有的节点的子节点, 如存在属性dance, 则加上材质WindSway
	for node in get_children():
		if node is MoveableObject:
			# 增加摇摆动画
			node.get_node('Sprite2D').material = ShaderMaterial.new()
			node.get_node('Sprite2D').material.shader = dance_shader
			node.get_node('Sprite2D').material.set_shader_parameter('strength', 2.)
			node.get_node('Sprite2D').material.set_shader_parameter('speed', 3.)
			
				
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
