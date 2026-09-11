extends Area2D
## VACUUM HEROES – Dirt pile

@export var dirt_value: int = 10
@export var max_hp: float = 30.0
@export var pickup_sound: AudioStream

var current_hp: float
var is_collected: bool = false
var _overlapping: bool = false

func _ready() -> void:
	current_hp = max_hp
	add_to_group("dirt")
	monitoring = true
	monitorable = true
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.is_in_group("vacuum"):
		_overlapping = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") or body.is_in_group("vacuum"):
		_overlapping = false

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("vacuum") or area.is_in_group("player"):
		_overlapping = true

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("vacuum") or area.is_in_group("player"):
		_overlapping = false

func _process(delta: float) -> void:
	if is_collected or not _overlapping:
		return
	var force := 100.0
	if GameManager and GameManager.has_method("get_suction_force"):
		force = GameManager.get_suction_force()
	# Prefer live vacuum node force
	var vacs = get_tree().get_nodes_in_group("vacuum")
	for v in vacs:
		if v.has_method("get_suction_force"):
			force = v.get_suction_force()
			break
	current_hp -= force * delta
	var vis = get_node_or_null("Visual")
	if vis and max_hp > 0:
		var s = clampf(current_hp / max_hp, 0.2, 1.0)
		vis.scale = Vector2(s, s)
	if current_hp <= 0.0:
		collect()

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
