extends Node
## VACUUM HEROES – IAP stub (wire to Godot Google Play / iOS plugins later)

const PRODUCT_IDS := [
	"com.vacuumheroes.vip.monthly",
	"com.vacuumheroes.vip.yearly",
	"com.vacuumheroes.battlepass.s1",
	"com.vacuumheroes.pack.starter",
	"com.vacuumheroes.pack.value",
	"com.vacuumheroes.pack.mega",
	"com.vacuumheroes.pack.elite",
	"com.vacuumheroes.gems.100",
	"com.vacuumheroes.gems.500",
	"com.vacuumheroes.gems.1200",
	"com.vacuumheroes.gems.2500",
]

signal purchase_succeeded(product_id: String)
signal purchase_failed(product_id: String, reason: String)

var vip_active: bool = false

func purchase(product_id: String) -> void:
	# TODO: call native billing
	push_warning("IAP stub purchase: " + product_id)
	_grant(product_id)
	purchase_succeeded.emit(product_id)

func restore_purchases() -> void:
	push_warning("IAP stub restore")

func _grant(product_id: String) -> void:
	if not Economy:
		return
	match product_id:
		"com.vacuumheroes.pack.starter":
			Economy.add_coins(1500)
			Economy.add_gems(80)
		"com.vacuumheroes.pack.value":
			Economy.add_coins(5000)
			Economy.add_gems(300)
		"com.vacuumheroes.pack.mega":
			Economy.add_coins(12000)
			Economy.add_gems(800)
		"com.vacuumheroes.pack.elite":
			Economy.add_coins(30000)
			Economy.add_gems(2000)
		"com.vacuumheroes.gems.100":
			Economy.add_gems(100)
		"com.vacuumheroes.gems.500":
			Economy.add_gems(500)
		"com.vacuumheroes.gems.1200":
			Economy.add_gems(1200)
		"com.vacuumheroes.gems.2500":
			Economy.add_gems(2500)
		"com.vacuumheroes.vip.monthly", "com.vacuumheroes.vip.yearly":
			vip_active = true
		_:
			pass
