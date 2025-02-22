extends Node3D

@export var healing_coefficient := 10
@export var damaging_coefficient := 3
@export var time_before_damage := 5.0

var in_game_music
var game_paused=false
var pause_screen = load("res://scenes/options.tscn").instantiate()
var interactables = []
var not_used = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_root().get_node("Main Game").get_node("WorldEnvironment").environment.adjustment_brightness = Persistence.config.get_value("Video","Brightness")
	in_game_music = get_node("Ingame")
	#Burada tüm interactables'i buraya geçirmemiz gerekiyor. Geçirmediklerimiz çalışmıyor. 
	interactables.append(get_node("Mimari/Kitchen/kitchenStove/InteractableOven"))
	interactables.append(get_node("Mimari/ÇalışmaOdası/laptop/InteractableLaptop"))
	interactables.append(get_node("Mimari/OturmaOdası/televisionVintage2/InteractableTV"))
	interactables.append(get_node("Mimari/OturmaOdası/radio/InteractableRadio"))
	interactables.append(get_node("Mimari/OturmaOdası/ceilingFan2/InteractableFan"))
	interactables.append(get_node("Mimari/Tuvalet/washerDryer/InteractableWashingMachine"))
	interactables.append(get_node("Mimari/Kitchen/kitchenFridge/InteractableFridge"))
	#Tüm interactable'ler eklendikten sonra
	not_used = interactables.duplicate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_screen = load("res://scenes/options.tscn").instantiate()
		game_paused = !game_paused
		pause_game()
	get_node("ColorRect").material.set_shader_parameter("transparency",remap($Player.health,0,$Player.max_health,0.3,0))
	get_node("ColorRect").material.set_shader_parameter("amount",remap($Player.health,0,$Player.max_health,3,1))
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
	var interactable_seed = randi_range(0,len(not_used)-1)
	var object = not_used[interactable_seed]
	object.is_threat = true
	object.is_used = true
	not_used.remove_at(interactable_seed)

func _on_threatify_timer_timeout() -> void:
	if len(not_used) > 0:
		threatify()
	else:
		$"Threatify Timer".queue_free()
		for i in interactables:
			if i.is_threat:
				return
		$"Health Timer".queue_free()
		$Player.health = $Player.max_health
		if in_game_music.playing:
			in_game_music.stop()
		await get_tree().create_timer(1.0).timeout
		get_node("ThreatGone").play()


func _on_health_timer_timeout() -> void:
	var player = get_node("Player")
	var active_threats_count = 0
	for i in interactables:
		if i.is_threat:
			active_threats_count +=1
	if active_threats_count>0:
		await get_tree().create_timer(time_before_damage).timeout
		player.health -= damaging_coefficient*active_threats_count
	else:
		player.health+= healing_coefficient
		
func game_lost():
	get_tree().change_scene_to_file("res://scenes/game_lost.tscn")

func game_win():
	get_tree().change_scene_to_file("res://scenes/game_win.tscn")
