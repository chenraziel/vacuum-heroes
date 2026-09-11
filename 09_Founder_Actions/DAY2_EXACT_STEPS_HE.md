# Day 2 – תנועת Player (עברית)

## מטרה
Player זז חלק עם drag/swipe על מסך מגע (וגם עכבר).

## צעדים
1. ודא ש-`player.gd` מחובר ל-CharacterBody2D
2. הוסף CollisionShape2D → RectangleShape2D (גודל ~64x64)
3. Sprite2D או ColorRect סגול כ-visual
4. Camera2D כ-child של Player → Enabled + Position Smoothing
5. Project Settings → Emulate Touch From Mouse = ON
6. הרץ → גרור → התנועה חלקה עם acceleration/friction

## DoD Day 2
- [ ] Drag מזיז את השואב
- [ ] שחרור → עצירה הדרגתית
- [ ] Camera עוקב
- [ ] אין יציאה מגבולות (אופציונלי: clamp ב-_physics_process)

## Clamp לדוגמה (הוסף ל-player.gd אם רוצה)
```gdscript
func _physics_process(delta: float) -> void:
	# ... existing move code ...
	move_and_slide()
	global_position.x = clampf(global_position.x, 40.0, 1040.0)
	global_position.y = clampf(global_position.y, 40.0, 1880.0)
```
