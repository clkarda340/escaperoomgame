extends Control

@onready var labels = [$VBoxContainer/Label,$VBoxContainer/Label2,$VBoxContainer/Label3,$VBoxContainer/Label4]  # Labels artık VBoxContainer içinde
@onready var continue_label = $VBoxContainer/ContinueLabel

var text_speed = 0.008  # Harflerin daha hızlı görünmesi için süreyi daha kısa yapıyoruz
var current_label_index = 0
var is_typing = false
var can_continue = false

# SAHNEDE GÖRÜNECEK METİNLER (Bunları değiştirebilirsin)
var label_texts = [
	"\n \n CONTENT WARNING \n \n",
	"Some individuals may experience seizures when exposed to 
certain visual stimuli, including flashing lights or patterns. \n \n",
	"If you have a history of seizures or epilepsy, please consult
a healthcare professional before engaging with this content. \n \n",
	"\n \n \n \n This game is about the feeling of something might be wrong. 
Character wakes up at night, and tries to conquer this feeling
 in order to get back to sleep. \n \n"
]

func _ready():
	# **Tüm Label'ları başta boş yap**
	print($VBoxContainer)
	for label in labels:
		label.set_text("")  # Godot 4'te metin ayarlamak için set_text() kullanılır.
	
	continue_label.visible = false  # "Press Any Key" başta gizli olacak
	start_typing()  # İlk metni yazdırmaya başla

func start_typing():
	if current_label_index < labels.size():
		is_typing = true
		await display_text(labels[current_label_index], label_texts[current_label_index])  # yield yerine await
		current_label_index += 1
		is_typing = false
		start_typing()  # Bir sonraki Label'a geç
	else:
		show_continue_label()  # Tüm metinler bitince devam etme mesajını göster

func display_text(label, full_text):
	for i in range(full_text.length()):
		label.set_text(full_text.substr(0, i + 1))  # set_text() kullanarak yazdırma işlemi
		await get_tree().create_timer(text_speed).timeout  # Harf harf yazdır

func show_continue_label():
	# 1 saniye bekleyip sonra "Press Any Key to Continue" mesajını göster
	await get_tree().create_timer(1.0).timeout  # 1 saniye bekleme
	continue_label.visible = true  # "Press Any Key" görünür olsun
	can_continue = true
	blink_continue_label()  # Yanıp sönme efekti başlat

func blink_continue_label():
	var tween = create_tween()
	tween.tween_property(continue_label, "modulate:a", 0.0, 0.5).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(continue_label, "modulate:a", 1.0, 0.5).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(blink_continue_label)  # Sonsuz döngü

func _input(event):
	if can_continue and event.is_pressed():
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")  # Bir sonraki sahneye geç
