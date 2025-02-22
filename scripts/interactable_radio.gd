extends Area3D

var is_threat:=false
var is_used :=false
var radio_noise
var green_light
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	green_light = get_parent().get_node("GreenLight")
	radio_noise = get_parent().get_node("Tuning-radio-7150")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if is_threat==true:
		green_light.visible = true
		if radio_noise.playing == false:
			radio_noise.play()
		pass
	else:
		green_light.visible = false
		if radio_noise.playing == true:
			radio_noise.stop()
