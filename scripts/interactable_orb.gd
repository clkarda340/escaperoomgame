extends Area3D

var is_threat:=false
var is_used :=false
var globe_noise
var pink_light
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pink_light = get_parent().get_node("PinkLight")
	globe_noise = get_parent().get_node("SnowGlobeSong")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if is_threat==true:
		pink_light.visible = true
		if globe_noise.playing == false:
			globe_noise.play()
		pass
	else:
		pink_light.visible = false
		if globe_noise.playing == true:
			globe_noise.stop()
