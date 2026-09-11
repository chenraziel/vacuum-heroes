extends Control
## VACUUM HEROES – Victory panel

@onready var stars_label: Label = $StarsLabel
@onready var score_label: Label = $ScoreLabel
@onready var coins_label: Label = $CoinsLabel
@onready var next_btn: Button = $NextButton
@onready var replay_btn: Button = $ReplayButton

func _ready() -> void:
	visible = false
	if next_btn:
		next_btn.pressed.connect(_on_next)
	if replay_btn:
		replay_btn.pressed.connect(_on_replay)

func show_victory(stars: int, score: int, coins: int) -> void:
	visible = true
	if stars_label:
		stars_label.text = "★".repeat(stars) + "☆".repeat(3 - stars)
	if score_label:
		score_label.text = "SCORE: %d" % score
	if coins_label:
		coins_label.text = "+%d" % coins
	if Economy:
		Economy.add_coins(coins)

func _on_next() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/level_select.tscn")

func _on_replay() -> void:
	get_tree().reload_current_scene()
