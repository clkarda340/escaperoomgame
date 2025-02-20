extends Node3D

var paused=false
var pause_screen = load("res://scenes/options.tscn").instantiate()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_root().get_child(1).get_node("WorldEnvironment").environment.adjustment_brightness = Persistence.config.get_value("Video","Brightness")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_screen = load("res://scenes/options.tscn").instantiate()
		paused = !paused
		pause_game()
		
func pause_game():
	if paused:
		if get_tree().get_root().get_node("Options"):
			return
		get_tree().get_root().add_child(pause_screen)
	else:
		pause_screen.queue_free()
