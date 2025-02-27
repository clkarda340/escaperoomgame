extends Area3D

var is_threat := true
var game_finished := false
var main_game 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_game = get_tree().get_root().get_node("Main Game")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if is_threat == false:
		if is_game_finished():
			main_game.get_node("Player").release_mouse()
			main_game.game_win()
		else:
			is_threat = true
func is_game_finished():
	for i in main_game.interactables:
		if i.is_used == false:
			return 0
	game_finished=true
	return 1
