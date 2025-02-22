extends Area3D

var is_threat:=false
var is_used :=false
var machine_anim
var machine_sound
var playing := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	machine_anim = get_parent().get_node("FridgeShiver")
	machine_sound = get_parent().get_node("broken-fridge")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if is_threat==true:
		in_threat()
	else:
		not_in_threat()

func in_threat():
	if machine_sound.playing == false:
		machine_sound.play()
	machine_anim.play("shiver")
	
func not_in_threat():
	if machine_sound.playing:
		machine_sound.stop()
	machine_anim.play("RESET")
	machine_anim.stop()	
