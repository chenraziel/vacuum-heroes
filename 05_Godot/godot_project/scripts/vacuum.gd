extends Node2D
## VACUUM HEROES – Suction + Turbo

@export var base_suction: float = 100.0
@export var turbo_multiplier: float = 2.5
@export var turbo_duration: float = 1.2
@export var turbo_cooldown: float = 2.5

var current_suction: float
var is_turbo: bool = false
var turbo_timer: float = 0.0
var cooldown_timer: float = 0.0

signal turbo_started
signal turbo_ended

func _ready() -> void:
	current_suction = base_suction
	add_to_group("vacuum")

func _process(delta: float) -> void:
	if is_turbo:
		turbo_timer -= delta
		if turbo_timer <= 0.0:
			_end_turbo()
	if cooldown_timer > 0.0:
		cooldown_timer -= delta
	# Hold to turbo (mouse/touch)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or _any_touch():
		try_activate_turbo()

func _any_touch() -> bool:
	for i in range(Input.get_connected_joypads().size() + 5):
		pass
	# Simple: also check screen touch via InputMap if configured
	return Input.is_action_pressed("turbo") if InputMap.has_action("turbo") else false

func try_activate_turbo() -> bool:
	if is_turbo or cooldown_timer > 0.0:
		return false
	is_turbo = true
	turbo_timer = turbo_duration
	current_suction = base_suction * turbo_multiplier
	turbo_started.emit()
	return true

func _end_turbo() -> void:
	is_turbo = false
	current_suction = base_suction
	cooldown_timer = turbo_cooldown
	turbo_ended.emit()

func get_suction_force() -> float:
	return current_suction
