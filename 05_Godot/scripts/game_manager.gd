extends Node
## VACUUM HEROES – GameManager Autoload

signal score_changed(value: int)
signal combo_changed(value: int)
signal time_changed(value: float)

var score: int = 0
var combo: int = 1
var combo_timer: float = 0.0
var time_left: float = 90.0
var dirt_cleaned: int = 0
var suction_force: float = 100.0

func _process(delta: float) -> void:
	if combo > 1:
		combo_timer -= delta
		if combo_timer <= 0.0:
			combo = 1
			combo_changed.emit(combo)

func reset_run(level_time: float = 90.0) -> void:
	score = 0
	combo = 1
	combo_timer = 0.0
	time_left = level_time
	dirt_cleaned = 0
	score_changed.emit(score)
	combo_changed.emit(combo)
	time_changed.emit(time_left)

func add_score(amount: int) -> void:
	score += amount * combo
	score_changed.emit(score)

func add_combo() -> void:
	combo += 1
	combo_timer = 2.5
	combo_changed.emit(combo)

func add_dirt_cleaned(amount: int = 1) -> void:
	dirt_cleaned += amount

func get_suction_force() -> float:
	return suction_force

func set_suction_force(value: float) -> void:
	suction_force = value
