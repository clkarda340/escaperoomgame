extends Control

func _ready() -> void:
	var screen_type = Persistence.config.get_value("Video","FullscreenCheck")
	if screen_type == DisplayServer.WINDOW_MODE_FULLSCREEN:
		$"%FullscreenCheck".button_pressed = true
	
	var borderless = Persistence.config.get_value("Video","BorderlessCheck")
	if borderless:
		$"%BorderlessCheck".button_pressed = true
		
	$"%VSync".selected = Persistence.config.get_value("Video","VSync")
	
	%Brightness.value = Persistence.config.get_value("Video","Brightness")
	
	%SFX.value = Persistence.config.get_value("Audio","1")
	AudioServer.set_bus_volume_db(0,linear_to_db(%SFX.value))
	
	%Music.value = Persistence.config.get_value("Audio","2")
	AudioServer.set_bus_volume_db(0,linear_to_db(%Music.value))
	
	%Master.value = Persistence.config.get_value("Audio","0")
	AudioServer.set_bus_volume_db(0,linear_to_db(%Master.value))

func _on_back_pressed() -> void:
	get_tree().paused = false
	get_parent().get_parent().queue_free()

func _on_brightness_value_changed(value: float) -> void:
	var main_game = get_tree().get_root().get_node_or_null("Main Game")
	if main_game != null:
		main_game.get_node("WorldEnvironment").environment.adjustment_brightness = value
	Persistence.config.set_value("Video","Brightness",value)
	Persistence.save_data()

func _on_fullscreen_check_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Persistence.config.set_value("Video","FullscreenCheck",DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Persistence.config.set_value("Video","FullscreenCheck",DisplayServer.WINDOW_MODE_WINDOWED)
	Persistence.save_data()
	
func _on_borderless_check_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,toggled_on)
	Persistence.config.set_value("Video","BorderlessCheck",toggled_on)
	Persistence.save_data()
	
func _on_v_sync_item_selected(index: int) -> void:
	DisplayServer.window_set_vsync_mode(index)
	Persistence.config.set_value("Video","VSync",index)
	Persistence.save_data()
	
	
func _on_master_value_changed(value: float) -> void:
	set_volume(0,value)
func _on_sfx_value_changed(value: float) -> void:
	set_volume(1,value)
func _on_music_value_changed(value: float) -> void:
	set_volume(2,value)
func set_volume(idx,value):
	AudioServer.set_bus_volume_db(idx,linear_to_db(value))
	Persistence.config.set_value("Audio",str(idx),value)
	Persistence.save_data()


func _on_quit_pressed() -> void:
	get_tree().quit()
