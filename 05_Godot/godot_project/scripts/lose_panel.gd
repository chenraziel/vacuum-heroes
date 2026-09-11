extends Control
## VACUUM HEROES – Defeat panel

@onready var reason_label: Label = $ReasonLabel
@onready var score_label: Label = $ScoreLabel
@onready var retry_btn: Button = $RetryButton
@onready var home_btn: Button = $HomeButton

func _ready() -> void:
	visible = false
	if retry_btn:
		retry_btn.pressed.connect(_on_retry)
	if home_btn:
		home_btn.pressed.connect(_on_home)

func show_defeat(reason: String, score: int) -> void:
	visible = true
	if reason_label:
		reason_label.text = "נגמר הזמן!" if reason == "time_up" else "הפסד"
	if score_label:
		score_label.text = "SCORE: %d" % score

func _on_retry() -> void:
	get_tree().reload_current_scene()

func _on_home() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
