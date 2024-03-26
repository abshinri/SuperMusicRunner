class_name BackgroundObject extends Node2D

const dance_shader = preload ("res://Shader/Swing.gdshader")

func _ready():
	print('BackgroundObject')
	SignalBank.start_dance.connect(Callable(self,'_on_start_dance'))

func _on_start_dance():
	print('_on_start_dance')
	print(self)
	get_node('Sprite2D').material = ShaderMaterial.new()
	get_node('Sprite2D').material.shader = dance_shader
	get_node('Sprite2D').material.set_shader_parameter('strength', 2.)
	get_node('Sprite2D').material.set_shader_parameter('speed', 3.)
