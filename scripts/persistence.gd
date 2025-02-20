extends Node

const PATH="user://settings.cfg"
var config= ConfigFile.new()

func _ready() -> void:
	config.set_value("Video","FullscreenCheck",DisplayServer.WINDOW_MODE_WINDOWED)
	config.set_value("Video","BorderlessCheck",false)
	config.set_value("Video","VSync",DisplayServer.VSYNC_ENABLED)
	config.set_value("Video","Brightness",1.5)
	
	for i in range(3):
		config.set_value("Audio",str(i),0.5)
		
	load_data()
	
func save_data():
	config.save(PATH)

func load_data():
	if config.load(PATH) != OK:
		save_data()
		return
	load_video_settings()
	
func load_video_settings():
	var screen_type = config.get_value("Video","FullscreenCheck")
	DisplayServer.window_set_mode(screen_type)
	var borderless = config.get_value("Video","BorderlessCheck")
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,borderless)
	var vsync = config.get_value("Video","VSync")
	DisplayServer.window_set_vsync_mode(vsync)
	var brightness = config.get_value("Video","Brightness")
	
	
