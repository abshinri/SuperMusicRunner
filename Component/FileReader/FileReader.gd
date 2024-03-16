extends Control

@export var file_type: Array = ['ogg']

var file_path: String
var file_reader_loaded

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().files_dropped.connect(Callable(self, '_get_dropped_filesPath'))
	pass # Replace with function body.

func _get_dropped_filesPath(files):
	print(files)
	## 传入的文件格式必须符合数组file_type中的格式
	if files.size() == 0:
		return
	var fileExtension = files[0].get_extension()
	## 转为小写
	fileExtension = fileExtension.to_lower()
	if file_type.find(fileExtension) == - 1:
		print('文件格式不符合')
		return
	file_path = files[0]
	
	SignalBank.file_reader_loaded.emit(AudioStreamOggVorbis.load_from_file(file_path))
	pass

