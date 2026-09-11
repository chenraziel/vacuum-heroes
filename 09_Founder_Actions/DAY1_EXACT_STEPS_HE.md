# Day 1 – הוראות מדויקות (עברית)

## לפני שמתחילים
1. הורד Godot 4.3+ מ: https://godotengine.org/download
2. שכפל את הריפו: `git clone https://github.com/chenraziel/vacuum-heroes.git`
3. או הורד מ-Drive: VACUUM_HEROES_MASTER_PACKAGE.tar.gz

## צעדים ב-Godot (45–90 דקות)

### 1. פרויקט חדש
- New Project → שם: `VacuumHeroes`
- Renderer: **Mobile**
- Create & Edit

### 2. העתקת קבצים
מהחבילה `05_Godot/scripts/` העתק ל-`res://scripts/`:
- player.gd, vacuum.gd, dirt.gd, gem.gd
- economy.gd, game_manager.gd, level.gd, hud.gd

### 3. Autoload
Project → Project Settings → Autoload:
1. Path: `res://scripts/economy.gd` → Name: `Economy` → Add
2. Path: `res://scripts/game_manager.gd` → Name: `GameManager` → Add
סדר: Economy קודם, אחר כך GameManager

### 4. Display
Project Settings → Display → Window:
- Viewport Width: 1080
- Viewport Height: 1920
- Orientation: Portrait
- Stretch Mode: canvas_items
- Aspect: keep_width
- Emulate Touch From Mouse: ON

### 5. תיקיות
צור: scenes/, scenes/ui/, scenes/levels/, assets/, audio/

### 6. Scene ראשונה (placeholder)
- Node2D בשם `TestArena`
- הוסף ColorRect (רקע אפור)
- הוסף CharacterBody2D בשם Player + CollisionShape2D + ColorRect סגול
- צרף `player.gd`
- שמור: `scenes/test_arena.tscn`
- Run (F5) → בחר test_arena → גרור עם העכבר

### 7. Definition of Done – Day 1
- [ ] פרויקט נפתח בלי error
- [ ] Autoload עובד (print ב-_ready של Economy)
- [ ] Player זז ב-drag
- [ ] Portrait נכון

כשסיימת: שלח "Day 1 done" + screenshot.
