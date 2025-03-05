extends Area3D

var is_threat:=false:
	set(value):
		if value:
			if is_open:
				var wiggle_or_slam = randi_range(0,10)
				if wiggle_or_slam>3:
					animation.play("door_wiggle")
					is_threat = value
				else:
					animation.play("door_slam")
					is_threat = false
					is_used = true
					is_open = false
		else:
			is_threat = value
var interactables
var not_used
var is_used :=false
var is_open := false:
	set(value):
		if value:
			if is_used == false:
				interactables.append(self)
				get_tree().get_root().get_node("Main Game").not_used.append(self)
			is_open = value
		else:
			interactables.erase(self)
			get_tree().get_root().get_node("Main Game").not_used.erase(self)
			is_open = value
			
var animation
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	animation = get_parent().get_parent().get_node("DoorAnimations")
	interactables = get_tree().get_root().get_node("Main Game").interactables
	not_used =get_tree().get_root().get_node("Main Game").not_used
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		pass

func change_door_state():
	if is_open:
		animation.play("door_close")
		is_open = false
		is_threat = false
	else:
		animation.play("door_open")
		is_open = true
	
