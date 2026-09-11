extends CanvasLayer
## VACUUM HEROES – Basic HUD

@onready var score_label: Label = $ScoreLabel
@onready var timer_label: Label = $TimerLabel
@onready var energy_label: Label = $EnergyLabel
@onready var combo_label: Label = $ComboLabel

func _ready() -> void:
	if GameManager:
		GameManager.score_changed.connect(_on_score_changed)
		GameManager.combo_changed.connect(_on_combo_changed)
		GameManager.time_changed.connect(_on_time_changed)
	if Economy:
		Economy.energy_changed.connect(_on_energy_changed)
	_refresh()

func _refresh() -> void:
	if GameManager and score_label:
		score_label.text = "SCORE: %d" % GameManager.score
	if GameManager and timer_label:
		timer_label.text = "TIME: %02d" % int(GameManager.time_left)
	if GameManager and combo_label:
		combo_label.text = ("x%d" % GameManager.combo) if GameManager.combo > 1 else ""
	if Economy and energy_label:
		energy_label.text = "ENERGY: %d" % Economy.energy

func _on_score_changed(value: int) -> void:
	if score_label:
		score_label.text = "SCORE: %d" % value

func _on_combo_changed(value: int) -> void:
	if combo_label:
		combo_label.text = ("x%d" % value) if value > 1 else ""

func _on_time_changed(value: float) -> void:
	if timer_label:
		timer_label.text = "TIME: %02d" % int(value)

func _on_energy_changed(value: int) -> void:
	if energy_label:
		energy_label.text = "ENERGY: %d" % value
