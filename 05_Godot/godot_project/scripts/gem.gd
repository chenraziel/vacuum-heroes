extends Area2D
## VACUUM HEROES – Collectible gem

@export var gem_value: int = 50
@export var gem_color: Color = Color(1.0, 0.4, 1.0)
@export var pickup_sound: AudioStream

var is_collected: bool = false

func _ready() -> void:
	add_to_group("gem")
	modulate = gem_color
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func _on_body_entered(body: Node2D) -> void:
	_try_collect(body)

func _on_area_entered(area: Area2D) -> void:
	_try_collect(area)

func _try_collect(node: Node) -> void:
	if is_collected:
		return
	if node.is_in_group("player") or node.is_in_group("vacuum"):
		collect()

func collect() -> void:
	is_collected = true
	if Economy:
		Economy.add_coins(gem_value)
	if GameManager:
		GameManager.add_score(gem_value)
		GameManager.add_combo()
	var level = get_tree().get_first_node_in_group("level")
	if level and level.has_method("on_gem_collected"):
		level.on_gem_collected()
	queue_free()
