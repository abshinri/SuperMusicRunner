class_name BackgroundObject extends Node2D

const dance_shader = preload ("res://Shader/Swing.gdshader")
const flying_notes = preload ("res://Object/FlyingNotes/FlyingNotes.tscn")

func _ready():
	SignalBank.start_dance.connect(Callable(self,'_on_start_dance'))

func _on_start_dance():
	var sprite2D = get_node('Sprite2D')
	sprite2D.material = ShaderMaterial.new()
	sprite2D.material.shader = dance_shader
	sprite2D.material.set_shader_parameter('strength', 2.)
	sprite2D.material.set_shader_parameter('speed', 3.)
	sprite2D.add_child(flying_notes.instantiate())
