extends Node
## VACUUM HEROES – AudioManager Autoload stub

@export var suction_loop: AudioStream
@export var gem_sfx: AudioStream
@export var win_sfx: AudioStream
@export var lose_sfx: AudioStream
@export var click_sfx: AudioStream
@export var music: AudioStream

var _sfx: AudioStreamPlayer
var _music: AudioStreamPlayer
var sfx_on: bool = true
var music_on: bool = true

func _ready() -> void:
	_sfx = AudioStreamPlayer.new()
	_music = AudioStreamPlayer.new()
	_music.bus = "Master"
	add_child(_sfx)
	add_child(_music)

func play_sfx(stream: AudioStream) -> void:
	if not sfx_on or stream == null:
		return
	_sfx.stream = stream
	_sfx.play()

func play_gem() -> void:
	play_sfx(gem_sfx)

func play_win() -> void:
	play_sfx(win_sfx)

func play_lose() -> void:
	play_sfx(lose_sfx)

func play_click() -> void:
	play_sfx(click_sfx)

func start_music() -> void:
	if not music_on or music == null:
		return
	_music.stream = music
	_music.play()

func set_sfx(on: bool) -> void:
	sfx_on = on

func set_music(on: bool) -> void:
	music_on = on
	if not on:
		_music.stop()
	elif music:
		start_music()
