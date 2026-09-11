extends Node
## VACUUM HEROES – simple HE/EN locale (Autoload optional: Locale)

var lang: String = "he"  # "he" | "en"
var _data: Dictionary = {}

func _ready() -> void:
	_load()
	# Detect system later; default Hebrew for IL soft launch
	if OS.get_locale_language() != "he":
		lang = "en"

func _load() -> void:
	var path := "res://data/strings_he_en.json"
	if not FileAccess.file_exists(path):
		path = "res://localization/strings_he_en.json"
	if FileAccess.file_exists(path):
		var f := FileAccess.open(path, FileAccess.READ)
		var json := JSON.new()
		if json.parse(f.get_as_text()) == OK:
			_data = json.data

func t(key: String) -> String:
	if not _data.has(key):
		return key
	var entry = _data[key]
	if typeof(entry) == TYPE_DICTIONARY:
		return str(entry.get(lang, entry.get("en", key)))
	return str(entry)

func set_lang(code: String) -> void:
	lang = code
