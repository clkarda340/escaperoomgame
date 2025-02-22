extends Area3D


var is_threat:=false
var is_used :=false
var computer_light
var projected_light
var computer_sound
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projected_light = get_parent().get_node("ProjectedLight")
	computer_light = get_parent().get_node("ScreenLight")
	computer_sound = get_parent().get_node("ComputerSound")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if is_threat==true:
		in_threat()
	else:
		not_in_threat()

func in_threat():
	projected_light.visible = true
	computer_light.visible = true
	if !computer_sound.playing:
		computer_sound.play()
	
func not_in_threat():
	projected_light.visible = false
	computer_light.visible = false
	is_used = true
