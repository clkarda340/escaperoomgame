extends Area3D

var is_threat:=false
var is_used :=false
var oven_light
var oven_timer
var kitchen_light
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	oven_light = get_parent().get_node("KitchenOvenLight")
	oven_timer = get_parent().get_node("Oven-timer")
	kitchen_light = $"../KitchenLightBlink"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if is_threat==true:
		oven_light.visible = true
		in_threat()
		pass
	else:
		oven_light.visible = false
		kitchen_light.stop()

func in_threat():
	var kitchen_light = $"../KitchenLightBlink"
	kitchen_light.play("blink")
	
