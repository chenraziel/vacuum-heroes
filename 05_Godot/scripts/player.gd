extends CharacterBody2D
## VACUUM HEROES – Player movement (swipe/drag)

@export var move_speed: float = 420.0
@export var acceleration: float = 18.0
@export var friction: float = 12.0

var _move_dir: Vector2 = Vector2.ZERO
var _touching: bool = false

func _ready() -> void:
	add_to_group("player")

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		_touching = event.pressed
		if not event.pressed:
			_move_dir = Vector2.ZERO
	elif event is InputEventScreenDrag and _touching:
		_move_dir = event.relative.normalized()
		# Optional: use position delta toward finger for direct follow
	elif event is InputEventMouseButton:
		_touching = event.pressed
		if not event.pressed:
			_move_dir = Vector2.ZERO
	elif event is InputEventMouseMotion and _touching:
		_move_dir = event.relative.normalized()

func _physics_process(delta: float) -> void:
	if _move_dir.length() > 0.05:
		var target_vel := _move_dir * move_speed
		velocity = velocity.lerp(target_vel, acceleration * delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction * delta)
	move_and_slide()

func on_swipe(swipe_vector: Vector2) -> void:
	_move_dir = swipe_vector.normalized()
