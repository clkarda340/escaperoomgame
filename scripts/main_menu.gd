extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_game.tscn")
	

func _on_options_pressed() -> void:
	get_tree().get_root().add_child(load("res://scenes/options.tscn").instantiate())
	
