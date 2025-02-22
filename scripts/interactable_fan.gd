extends Area3D


var is_threat:=false
var is_used :=false
var fan_anim
var fan_sound
var playing := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fan_anim = get_parent().get_node("FanAnimation")
	fan_sound = get_parent().get_node("FanNoise")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if is_threat==true:
		in_threat()
	else:
		not_in_threat()

func in_threat():
	if fan_sound.playing == false:
		fan_sound.play()
	fan_anim.play("play")
	
func not_in_threat():
	if fan_sound.playing:
		fan_sound.stop()
	fan_anim.stop()	
