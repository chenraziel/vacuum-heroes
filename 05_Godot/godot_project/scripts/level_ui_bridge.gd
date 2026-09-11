extends Node
## Attach under Level – connects level_won / level_lost to panels

@export var win_panel_path: NodePath
@export var lose_panel_path: NodePath

@onready var level: Node = get_parent()

func _ready() -> void:
	if level.has_signal("level_won"):
		level.level_won.connect(_on_won)
	if level.has_signal("level_lost"):
		level.level_lost.connect(_on_lost)

func _on_won(stars: int, score: int) -> void:
	var panel = get_node_or_null(win_panel_path)
	if panel and panel.has_method("show_victory"):
		panel.show_victory(stars, score, 50 * stars)

func _on_lost(reason: String) -> void:
	var panel = get_node_or_null(lose_panel_path)
	var score := GameManager.score if GameManager else 0
	if panel and panel.has_method("show_defeat"):
		panel.show_defeat(reason, score)
