extends Control
## VACUUM HEROES – Main Menu stub

@onready var play_btn: Button = $PlayButton
@onready var coins_label: Label = $CoinsLabel
@onready var energy_label: Label = $EnergyLabel

func _ready() -> void:
	if play_btn:
		play_btn.pressed.connect(_on_play)
	_refresh()
	if Economy:
		Economy.coins_changed.connect(func(_v): _refresh())
		Economy.energy_changed.connect(func(_v): _refresh())

func _refresh() -> void:
	if Economy and coins_label:
		coins_label.text = str(Economy.coins)
	if Economy and energy_label:
		energy_label.text = "%d/100" % Economy.energy

func _on_play() -> void:
	if Economy and not Economy.can_enter_level():
		# TODO: show energy popup
		push_warning("Not enough energy")
		return
	get_tree().change_scene_to_file("res://scenes/levels/kitchen.tscn")
