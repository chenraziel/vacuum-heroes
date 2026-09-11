# Day 3 – Suction + Turbo (עברית)

## מטרה
Hold = Turbo, Area2D מזהה dirt/gems.

## צעדים
1. הוסף Node2D/Area2D בשם VacuumHead כ-child של Player
2. צרף `vacuum.gd`
3. CollisionShape2D (Circle) על ה-Area2D – רדיוס ~80
4. monitoring = true, monitorable = true
5. Input Map: action `turbo` (או השאר mouse left בסקריפט)
6. Visual: PointLight2D או ColorRect כחול בזמן turbo (חבר ל-signal turbo_started/ended)
7. צור dirt placeholder (Area2D + dirt.gd) ובדוק איסוף

## DoD Day 3
- [ ] Hold מפעיל turbo (או cooldown עובד)
- [ ] Dirt נעלם אחרי suction
- [ ] Score / coins עולים (Economy)
