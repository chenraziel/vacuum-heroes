extends Control
## VACUUM HEROES – Pause menu

@onready var resume_btn: Button = $ResumeButton
@onready var home_btn: Button = $HomeButton
@onready var sound_btn: Button = $SoundButton

var sound_on: bool = true

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	if resume_btn:
		resume_btn.pressed.connect(_on_resume)
	if home_btn:
		home_btn.pressed.connect(_on_home)
	if sound_btn:
		sound_btn.pressed.connect(_on_sound)

func open_pause() -> void:
	visible = true
	get_tree().paused = true

func _on_resume() -> void:
	visible = false
	get_tree().paused = false

func _on_home() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

func _on_sound() -> void:
	sound_on = not sound_on
	AudioServer.set_bus_mute(0, not sound_on)
	if sound_btn:
		sound_btn.text = "Sound: ON" if sound_on else "Sound: OFF"

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if visible:
			_on_resume()
		else:
			open_pause()
