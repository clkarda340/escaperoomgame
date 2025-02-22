extends Area3D

var is_threat:=false
var is_used :=false
var decal
var tv_static
var red_light
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	red_light = get_parent().get_node("TvRedDot")
	decal = get_parent().get_node("Decal")
	tv_static = get_parent().get_node("tv-static")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if is_threat==true:
		decal.visible = true
		if tv_static.playing == false:
			tv_static.play()
		pass
	else:
		decal.visible = false
		if tv_static.playing == true:
			tv_static.stop()

	
