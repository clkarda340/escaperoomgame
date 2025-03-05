extends Control

@onready var labels = [$Heading/Label1,$Heading2/Label2,$Heading3/Label3,$Heading4/Label4]  # Labels artık VBoxContainer içinde
@onready var continue_label = $Heading5/ContinueLabel

var text_speed = 0.01  # Harflerin daha hızlı görünmesi için süreyi daha kısa yapıyoruz
var current_label_index = 0
var is_typing = false
var can_continue = false

# SAHNEDE GÖRÜNECEK METİNLER (Bunları değiştirebilirsin)
var label_texts = [
	"CONTENT WARNİNG",
	"Some individuals may experience seizures when exposed to 
certain visual stimuli, including flashing lights or patterns.",
	"If you have a history of seizures or epilepsy, please consult
a healthcare professional before engaging with this content.",
	"This game is about the feeling of something might be wrong. 
Character wakes up at night, and tries to conquer this feeling
 in order to get back to sleep."
]

func _ready():
	# **Tüm Label'ları başta boş yap**
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
		get_tree().change_scene_to_file("res://next_scene.tscn")  # Bir sonraki sahneye geç
