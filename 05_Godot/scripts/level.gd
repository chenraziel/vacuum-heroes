extends Node2D
## VACUUM HEROES – Level controller

signal level_won(stars: int, score: int)
signal level_lost(reason: String)

@export var level_id: String = "kitchen_01"
@export var level_time: float = 90.0
@export var target_dirt: int = 12

var time_left: float
var dirt_remaining: int
var gems_collected: int = 0
var is_running: bool = false
var is_finished: bool = false

func _ready() -> void:
	add_to_group("level")
	time_left = level_time
	dirt_remaining = get_tree().get_nodes_in_group("dirt").size()
	if dirt_remaining == 0:
		dirt_remaining = target_dirt
	is_running = true
	if GameManager:
		GameManager.reset_run(level_time)
	if Economy and not Economy.spend_energy_for_level():
		# Not enough energy – could bounce to menu
		pass

func _process(delta: float) -> void:
	if not is_running or is_finished:
		return
	time_left -= delta
	if GameManager:
		GameManager.time_left = time_left
		GameManager.time_changed.emit(time_left)
	if time_left <= 0.0:
		_finish_lose("time_up")
		return
	_check_win()

func on_dirt_collected() -> void:
	dirt_remaining = max(dirt_remaining - 1, 0)
	_check_win()

func on_gem_collected() -> void:
	gems_collected += 1

func _check_win() -> void:
	if dirt_remaining <= 0:
		_finish_win()

func _finish_win() -> void:
	if is_finished:
		return
	is_finished = true
	is_running = false
	var stars := _calculate_stars()
	var final_score: int = GameManager.score if GameManager else 0
	if Economy:
		Economy.complete_level(level_id)
		Economy.add_coins(50 * stars)
	level_won.emit(stars, final_score)

func _finish_lose(reason: String) -> void:
	if is_finished:
		return
	is_finished = true
	is_running = false
	level_lost.emit(reason)

func _calculate_stars() -> int:
	var s: int = GameManager.score if GameManager else 0
	if s >= 15000 and time_left > 30:
		return 3
	elif s >= 8000:
		return 2
	return 1
