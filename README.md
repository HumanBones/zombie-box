# 🧟 Zombie Box

A top-down zombie survival game built in **Godot 4** using GDScript. Survive endless waves of zombies, earn upgrades between waves, and see how far you can push.

Built as a portfolio project to demonstrate game systems architecture, game feel, and Godot 4 best practices.

---

## 🎮 Gameplay

- Survive increasingly difficult waves of zombies
- Auto-shooting triggers when enemies enter range
- Choose from randomised upgrades between each wave
- Manage your health — reach zero and it's game over

---

## ✨ Features

| System | Details |
|---|---|
| 🔫 Auto-shoot | Player automatically targets and shoots the nearest enemy |
| 🌊 Wave Manager | Modular wave system with circle-area spawning |
| ⚡ Upgrade System | Data-driven, Resource-based upgrades — fully modular |
| ❤️ Health System | Health bars for player and enemies with on-hurt flash effects |
| 💥 Game Feel | Screen shake, blood particles, and dynamic lighting on hit |
| ⏸️ Pause Menu | Pause, resume, and quit to menu at any time |
| 💀 Game Over | Game over screen with transition back to main menu |
| 🎨 Main Menu | Clean main menu with fade-in animation |

---

## 🏗️ Architecture Highlights

### Upgrade System — Resource Pattern
Each upgrade extends a base `Upgrade` Resource and overrides a single `apply(player)` method. Adding a new upgrade is one `.tres` file — no match statements, no manager changes.

```
Upgrade (base Resource)
├── SpeedUpgrade.gd
├── FireRateUpgrade.gd
├── DamageUpgrade.gd
└── PierceUpgrade.gd
        ↓
Resources/Upgrades/
├── speed_boost_small.tres
├── speed_boost_large.tres
├── fire_rate_up.tres
└── ...
```

### Wave System
Wave data is defined as Resources (enemy types, counts, spawn delay). `WaveManager` reads and executes wave data independently from `SpawnManager`, keeping spawning logic and wave progression fully separated.

---

## 🛠️ Built With

- **Engine:** Godot 4
- **Language:** GDScript 100%
- **Patterns:** Resource-based data, signal-driven systems, modular components

---

## 📁 Project Structure

```
zombie-box/
├── Assets/         # Sprites, audio, fonts
├── Managers/       # WaveManager, GameManager autoloads
├── Resources/      # Upgrade .tres files, wave data
│   └── Upgrades/   # Individual upgrade resources
├── Scenes/         # All game scenes
└── project.godot
```

---

## 🚀 Running the Project

1. Download and install [Godot 4](https://godotengine.org/download)
2. Clone this repository
3. Open Godot, click **Import**, select `project.godot`
4. Press **F5** to run

---

## 🗺️ Roadmap

- [ ] Enemy AI — state machine (Chase, Attack, Hurt, Dead)
- [ ] Enemy variations — tank, runner with stat-based Resources
- [ ] Smoother player movement — acceleration, deceleration, aim rotation
- [ ] Art & SFX — proper sprites, sound effects, music
- [ ] Platform exports — Web (itch.io), Windows, Mac

---

## 👤 About

Made by **[HumanBones](https://github.com/HumanBones)** — aspiring game developer working toward founding an indie studio.

This project is a deliberate portfolio piece focused on clean architecture, game feel, and shippable scope — not just a tutorial follow-along.

| | |
|---|---|
| 🎮 **Play my games** | [humanbones.itch.io](https://humanbones.itch.io/) |
| 🌐 **Portfolio site** | [humanbones.xyz](https://humanbones.xyz/) |
| 🐙 **GitHub** | [github.com/HumanBones](https://github.com/HumanBones) |