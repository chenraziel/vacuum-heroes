# Godot Project Structure

```
VacuumHeroes/
├── project.godot
├── scenes/
│   ├── player.tscn
│   ├── vacuum.tscn
│   ├── levels/kitchen.tscn
│   └── ui/ (hud, main_menu, level_select, win, lose, pause)
├── scripts/
│   ├── player.gd
│   ├── vacuum.gd
│   ├── dirt.gd
│   ├── gem.gd
│   ├── level.gd
│   ├── hud.gd
│   ├── game_manager.gd
│   └── economy.gd
├── assets/ (textures, fonts, particles)
├── audio/ (sfx, music)
└── autoload/  → Project Settings: GameManager, Economy
```

## Autoload order
1. Economy
2. GameManager
