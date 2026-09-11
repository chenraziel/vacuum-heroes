extends Control
## VACUUM HEROES – 7-day daily rewards

const REWARDS := [50, 80, 100, 150, 200, 300, 500]  # coins
const SAVE_KEY := "daily_day"
const SAVE_TIME := "daily_last"

var current_day: int = 0

func _ready() -> void:
	_load_state()

func can_claim() -> bool:
	if not Economy:
		return true
	# one claim per calendar day via economy file fields if extended
	return true

func claim() -> void:
	if current_day >= REWARDS.size():
		current_day = 0
	var amount: int = REWARDS[current_day]
	if Economy:
		Economy.add_coins(amount)
	current_day += 1
	_save_state()

func _load_state() -> void:
	current_day = 0

func _save_state() -> void:
	pass
