# 🧟 Zombie Box

A top-down zombie survival game built in **Godot 4** using GDScript. Survive endless waves of zombies, collect upgrades between waves, and see how long you can last.

Built as a portfolio project to demonstrate game systems architecture, game feel, and Godot 4 best practices.

---

## 🎮 Gameplay

- Survive waves of zombies that increase in difficulty
- Auto-shooting triggers when enemies enter range
- Collect upgrades between waves to boost your stats
- Manage your health — one wrong move and it's over

---

## ✨ Features

| System | Details |
|---|---|
| 🔫 Auto-shoot | Player automatically targets and shoots nearby enemies |
| 🌊 Wave Manager | Modular wave spawner using circle-area spawn points |
| 💊 Upgrade System | Data-driven upgrade system using Godot Resources |
| ❤️ Health System | Health bars for both player and enemies with on-hurt effects |
| 💥 Game Feel | Screen shake, blood particles, and dynamic lighting on hit |
| 🧠 Enemy AI | State machine-driven enemy behaviour (Chase, Attack, Hurt, Dead) |
| 🎨 Main Menu | Clean main menu with fade-in transition |

---

## 🏗️ Architecture Highlights

### Upgrade System — Resource Pattern
Each upgrade is a `Resource` that extends a base `Upgrade` class and overrides a single `apply(player)` method. Adding a new upgrade means creating one `.tres` file — no code changes required anywhere else.

```
Upgrade (base Resource)
├── SpeedUpgrade.gd     → speed_boost_small.tres / speed_boost_large.tres
├── FireRateUpgrade.gd  → fire_rate_up.tres
├── DamageUpgrade.gd    → damage_up.tres
└── PierceUpgrade.gd    → pierce_shot.tres
```

### Enemy State Machine
Enemies use a modular state machine where each state is a self-contained class that handles its own logic and signals transitions. States: `Idle → Roam → Chase → Attack → Hurt → Dead`.

### Wave System
Wave data is defined as Resources (enemy types, counts, spawn delay). The `WaveManager` reads and executes wave data independently of the `SpawnManager`, keeping concerns separated.

### Hurtbox / Hitbox
Modular `Hurtbox` and `Hitbox` components using Godot's Area2D and signals. Any node can take damage by having a `Hurtbox` child — no hardcoded damage logic on individual entities.

---

## 🛠️ Built With

- **Engine:** Godot 4
- **Language:** GDScript
- **Architecture:** Resource-based data, signal-driven systems, modular components

---

## 📁 Project Structure

```
zombie-box/
├── Assets/         # Sprites, audio, fonts
├── Managers/       # WaveManager, GameManager autoloads
├── Resources/      # Upgrade .tres files, wave data
│   └── Upgrades/   # Individual upgrade resources
├── Scenes/         # All game scenes
│   ├── Entities/   # Player, Enemy scenes
│   ├── Components/ # Hurtbox, Hitbox, HealthBar
│   ├── UI/         # HUD, UpgradeScreen, GameOver
│   └── World/      # Main game scene, SpawnPoints
└── project.godot
```

---

## 🚀 Running the Project

1. Download and install [Godot 4](https://godotengine.org/download)
2. Clone this repository
3. Open Godot, click **Import**, and select the `project.godot` file
4. Press **F5** to run

---

## 🗺️ Roadmap

- [ ] Game over screen with wave count and survival time
- [ ] Local leaderboard (save/load with `FileAccess`)
- [ ] Second enemy type (tank zombie)
- [ ] Pause menu
- [ ] Web export on itch.io

---

## 👤 About

Made by **[HumanBones](https://github.com/HumanBones)** — aspiring game developer working toward founding an indie studio.

This project is a deliberate portfolio piece focused on clean architecture, game feel, and shippable scope — not just a tutorial follow-along.

| | |
|---|---|
| 🎮 **Play my games** | [humanbones.itch.io](https://humanbones.itch.io/) |
| 🌐 **Portfolio site** | [humanbones.xyz](https://humanbones.xyz/) |
| 🐙 **GitHub** | [github.com/HumanBones](https://github.com/HumanBones) |