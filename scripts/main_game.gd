extends Node3D

@export var healing_coefficient := 10
@export var damaging_coefficient := 3

var game_paused=false
var pause_screen = load("res://scenes/options.tscn").instantiate()
var interactables = []
var not_used = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_root().get_node("Main Game").get_node("WorldEnvironment").environment.adjustment_brightness = Persistence.config.get_value("Video","Brightness")
	interactables.append(get_node("Mimari/Kitchen/kitchenStove/InteractableOven"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_screen = load("res://scenes/options.tscn").instantiate()
		game_paused = !game_paused
		pause_game()
		
func pause_game():
	if game_paused:
		if get_tree().get_root().get_node_or_null("Options"):
			return
		get_tree().paused = true
		get_tree().get_root().add_child(pause_screen)
	else:
		pause_screen.queue_free()
		get_tree().paused = false
		

func threatify():
	var interactible_seed = randi_range(0,len(not_used)-1)
	var object = not_used[interactible_seed]
	object.is_threat = true
	object.is_used = true

func _on_threatify_timer_timeout() -> void:
	not_used = []
	for i in interactables:
		if i.is_threat == false and i.is_used == false:
			not_used.append(i)
	if len(not_used) > 0:
		threatify()
	else:
		$"Threatify Timer".queue_free()
		$"Health Timer".queue_free()
		$Player.health = $Player.max_health
		$Ingame.stop()
	#$"Threatify Timer".start() #EĞER LOOP İÇİNDE ÇALIŞMIYORSA BU KOD LAZIM 


func _on_health_timer_timeout() -> void:
	var player = get_node("Player")
	var active_threats_count = 0
	for i in interactables:
		if i.is_threat:
			active_threats_count +=1
	if active_threats_count>0:
		player.health -= damaging_coefficient*active_threats_count
	else:
		player.health+= healing_coefficient
		
func game_lost():
	get_tree().change_scene_to_file("res://scenes/game_lost.tscn")

func game_win():
	get_tree().change_scene_to_file("res://scenes/game_win.tscn")
