extends Node
## VACUUM HEROES – Economy Autoload

signal energy_changed(value: int)
signal coins_changed(value: int)
signal gems_changed(value: int)
signal economy_loaded

const SAVE_PATH := "user://economy.save"
const SAVE_VERSION := "1.0"
const MAX_ENERGY := 100
const ENERGY_PER_LEVEL := 10
const REGEN_SECONDS := 360.0

var coins: int = 0
var gems: int = 0
var energy: int = 100
var total_earnings: int = 0
var playtime_total: float = 0.0
var levels_completed: Array = []
var owned_skins: Array = ["default"]
var current_skin: String = "default"
var last_timestamp: int = 0

func _ready() -> void:
	load_economy()
	_apply_offline_regen()

func _process(delta: float) -> void:
	playtime_total += delta

func can_enter_level() -> bool:
	return energy >= ENERGY_PER_LEVEL

func spend_energy_for_level() -> bool:
	if not can_enter_level():
		return false
	energy -= ENERGY_PER_LEVEL
	energy_changed.emit(energy)
	save_economy()
	return true

func add_coins(amount: int) -> void:
	coins += amount
	total_earnings += amount
	coins_changed.emit(coins)
	save_economy()

func add_gems(amount: int) -> void:
	gems += amount
	gems_changed.emit(gems)
	save_economy()

func spend_gems(amount: int) -> bool:
	if gems < amount:
		return false
	gems -= amount
	gems_changed.emit(gems)
	save_economy()
	return true

func refill_energy_full() -> void:
	energy = MAX_ENERGY
	energy_changed.emit(energy)
	save_economy()

func complete_level(level_id: String) -> void:
	if level_id not in levels_completed:
		levels_completed.append(level_id)
	save_economy()

func save_economy() -> void:
	var data := {
		"version": SAVE_VERSION,
		"coins": coins,
		"gems": gems,
		"energy": energy,
		"total_earnings": total_earnings,
		"playtime_total": playtime_total,
		"levels_completed": levels_completed,
		"owned_skins": owned_skins,
		"current_skin": current_skin,
		"last_timestamp": int(Time.get_unix_time_from_system())
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(data)

func load_economy() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		last_timestamp = int(Time.get_unix_time_from_system())
		save_economy()
		economy_loaded.emit()
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var data = file.get_var()
		if typeof(data) == TYPE_DICTIONARY:
			coins = data.get("coins", 0)
			gems = data.get("gems", 0)
			energy = data.get("energy", MAX_ENERGY)
			total_earnings = data.get("total_earnings", 0)
			playtime_total = data.get("playtime_total", 0.0)
			levels_completed = data.get("levels_completed", [])
			owned_skins = data.get("owned_skins", ["default"])
			current_skin = data.get("current_skin", "default")
			last_timestamp = data.get("last_timestamp", int(Time.get_unix_time_from_system()))
	economy_loaded.emit()

func _apply_offline_regen() -> void:
	var now := int(Time.get_unix_time_from_system())
	var elapsed: int = max(now - last_timestamp, 0)
	var regen_amount: int = int(elapsed / REGEN_SECONDS)
	if regen_amount > 0 and energy < MAX_ENERGY:
		energy = mini(energy + regen_amount, MAX_ENERGY)
		energy_changed.emit(energy)
	last_timestamp = now
	save_economy()
