extends Area2D
## VACUUM HEROES – Dirt pile

@export var dirt_value: int = 10
@export var max_hp: float = 30.0
@export var pickup_sound: AudioStream

var current_hp: float
var is_collected: bool = false

func _ready() -> void:
	current_hp = max_hp
	add_to_group("dirt")
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func _on_body_entered(body: Node2D) -> void:
	_try_suction(body)

func _on_area_entered(area: Area2D) -> void:
	_try_suction(area)

func _try_suction(node: Node) -> void:
	if is_collected:
		return
	if node.is_in_group("player") or node.is_in_group("vacuum"):
		var force := 100.0
		if GameManager and GameManager.has_method("get_suction_force"):
			force = GameManager.get_suction_force()
		apply_suction(force)

func apply_suction(force: float) -> void:
	if is_collected:
		return
	current_hp -= force * get_process_delta_time()
	if current_hp <= 0.0:
		collect()

func _process(_delta: float) -> void:
	# Continuous suction while overlapping vacuum
	pass

func collect() -> void:
	is_collected = true
	if Economy:
		Economy.add_coins(dirt_value)
	if GameManager:
		GameManager.add_score(dirt_value)
		GameManager.add_dirt_cleaned(1)
	var level = get_tree().get_first_node_in_group("level")
	if level and level.has_method("on_dirt_collected"):
		level.on_dirt_collected()
	queue_free()
