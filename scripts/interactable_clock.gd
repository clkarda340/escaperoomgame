extends Area3D

var is_threat:=false
var is_used :=false
var clock_anim
var clock_sound
var playing := false
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	clock_anim = get_parent().get_node("ClockAnim")
	clock_sound = get_parent().get_node("ClockNoise")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if is_threat==true:
		in_threat()
	else:
		not_in_threat()

func in_threat():
	if clock_sound.playing == false:
		clock_sound.play()
	clock_anim.play("ring")
	
func not_in_threat():
	if clock_sound.playing:
		clock_sound.stop()
	clock_anim.stop()	
