extends Control

@export var file_type: Array = ['ogg']

var file_path: String
var _is_file_reader_loaded := false

# Called when the node enters the scene tree for the first time.
func _ready():
	#await _scan_local_files()
	#print(Global.file_reader_loaded_list)
	#await get_tree().create_timer(1.0).timeout
	#SignalBank.file_reader_loaded.emit()

	get_viewport().files_dropped.connect(Callable(self, '_get_dropped_filesPath'))
	pass # Replace with function body.

func _get_dropped_filesPath(files):
	if _is_file_reader_loaded:
		return
	# print(files)
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
	_is_file_reader_loaded = true	
	SignalBank.file_reader_loaded.emit(AudioStreamOggVorbis.load_from_file(file_path))
	pass

## 扫描本地的ogg和json文件
# 只有同时有同名的ogg和json文件才会被识别
#[{
#	name:String,
#	map:Dictionary,
#	stream:AudioStreamOggVorbis
#}]
#func _scan_local_files():
	#var file_list = []
	#var dir = DirAccess.open("Track")
	#var json_list = []
	#var ogg_list = []
	#if dir:
		#dir.list_dir_begin()
		#var file_name = dir.get_next()
		#while file_name != "":
			#if file_name.get_extension() == 'json':
				#json_list.append(file_name)
			#elif file_name.get_extension() == 'ogg':
				#ogg_list.append(file_name)
			#file_name = dir.get_next()
		#dir.list_dir_end()
	#else:
		#print('文件夹不存在')
		#return
	#for i in range(json_list.size()):
		#var json_name = json_list[i]
		#var ogg_name = json_name.get_basename() + '.ogg'
		#if ogg_list.find(ogg_name) != - 1:
			#var file = {
				#name = json_name.get_basename(),
				#map = load_json('Track//' + json_name),
				#stream = AudioStreamOggVorbis.load_from_file('Track//' + ogg_name)
			#}
			#file_list.append(file)
	#Global.file_reader_loaded_list = file_list
	#return true
	#
#func load_json(_file_path):
	#var file = FileAccess.open(_file_path, FileAccess.READ)
	#var content = file.get_as_text()
	#var json = JSON.new()
	#var error = json.parse(content)
	#if error == OK:
		#return json.data
	#else:
		#print("JSON Parse Error")
	#file.close()
	#return json
