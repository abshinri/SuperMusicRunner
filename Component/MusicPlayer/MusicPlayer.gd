class_name MusicPlayer extends Control
@export var file_reader: Node

const VU_COUNT = 30
const FREQ_MAX = 11050.0
const MIN_DB = 60
const ANIMATION_SPEED = 0.1
const HEIGHT_SCALE = 8.0

@onready var color_rect = $ColorRect

var spectrum
var min_values = []
var max_values = []

var playing = false
## 当前音乐波形图
var fft = []
## 当前音乐属性
var current_music_info := {
	bar_beats = 0,
	beat_count = 0,
	bpm = .0,
	length = .0,
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBank.file_reader_loaded.connect(Callable(self, '_load_and_play'))
	spectrum = AudioServer.get_bus_effect_instance(1, 0)
	min_values.resize(VU_COUNT)
	min_values.fill(0.0)
	max_values.resize(VU_COUNT)
	max_values.fill(0.0)
	pass # Replace with function body.

func _process(_delta) -> void:
	var prev_hz = 0
	var data = []
	for i in range(1, VU_COUNT + 1):
		var hz = i * FREQ_MAX / VU_COUNT
		var f = spectrum.get_magnitude_for_frequency_range(prev_hz, hz)
		var energy = clamp((MIN_DB + linear_to_db(f.length())) / MIN_DB, 0.0, 1.0)
		data.append(energy * HEIGHT_SCALE)
		prev_hz = hz
	for i in range(VU_COUNT):
		if data[i] > max_values[i]:
			max_values[i] = data[i]
		else:
			max_values[i] = lerp(max_values[i], data[i], ANIMATION_SPEED)
		if data[i] <= 0.0:
			min_values[i] = lerp(min_values[i], 0.0, ANIMATION_SPEED)
	fft = []
	for i in range(VU_COUNT):
		fft.append(lerp(min_values[i], max_values[i], ANIMATION_SPEED))
	if not playing:
		fft = []
	color_rect.get_material().set_shader_parameter("freq_data", fft)
	pass

func _init_music_info(stream:AudioStreamOggVorbis)->void:
	current_music_info.bar_beats = stream.bar_beats
	current_music_info.beat_count = stream.beat_count
	current_music_info.bpm = stream.bpm
	current_music_info.length = stream.get_length()

func _load_and_play() -> void:
	print('_load_and_play')
	var stream = Global.file_reader_loaded_list[0].stream
	_init_music_info(stream)
	$AudioStreamPlayer.stream = stream
	playing = true
	$AudioStreamPlayer.play()
	SignalBank.music_player_played.emit()
	await $AudioStreamPlayer.finished
	playing = false

# 这是拖拽播放的版本, 取消
# func _load_and_play(stream:AudioStreamOggVorbis) -> void:
# 	print('_load_and_play')
# 	_init_music_info(stream)
# 	$AudioStreamPlayer.stream = stream
# 	playing = true
# 	$AudioStreamPlayer.play()
# 	SignalBank.music_player_played.emit()
# 	await $AudioStreamPlayer.finished
# 	playing = false

func get_music_info() -> Dictionary:
	print('get_music_info')
	print(current_music_info)
	return current_music_info
	
func get_fft() -> Array:
	print('get_fft')
	print(fft)
	return fft
