extends Node
## VACUUM HEROES – Rewarded ads stub only

signal rewarded_completed(placement: String)
signal rewarded_failed(placement: String)

func show_rewarded(placement: String = "energy") -> void:
	# TODO: AdMob / LevelPlay
	push_warning("Rewarded ad stub: " + placement)
	# Simulate success in debug
	_on_reward(placement)

func _on_reward(placement: String) -> void:
	if placement == "energy" and Economy:
		Economy.energy = mini(Economy.energy + 20, Economy.MAX_ENERGY)
		Economy.energy_changed.emit(Economy.energy)
		Economy.save_economy()
	rewarded_completed.emit(placement)
