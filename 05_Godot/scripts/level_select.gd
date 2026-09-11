extends Control
## VACUUM HEROES – Level select stub

@export var level_buttons: Array[Button] = []
@export var level_scenes: Array[String] = [
	"res://scenes/levels/kitchen.tscn"
]

func _ready() -> void:
	for i in range(level_buttons.size()):
		var idx := i
		level_buttons[i].pressed.connect(func(): _open_level(idx))
		# Lock if not completed previous
		if i > 0 and Economy:
			var need := "kitchen_0%d" % i
			# simple unlock: first always open
			level_buttons[i].disabled = false

func _open_level(idx: int) -> void:
	if Economy and not Economy.can_enter_level():
		push_warning("Not enough energy")
		return
	if idx < level_scenes.size():
		get_tree().change_scene_to_file(level_scenes[idx])
