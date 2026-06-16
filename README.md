# RoboShooter

> A remote-controlled robot extraction shooter. Built with Godot 4.6 + GDScript. MIT licensed.
>
> [中文说明](README-zh.md) | [设计文档](docs/game-design-doc.md) ([English](docs/game-design-doc-en.md)) | [Dev Log](devlog.md)

---

## What Is This?

**You are a remote operator in a safe room. You control robot carriers sent into a fully-automated mining field.** When your robot is destroyed, your body is safe — but your gear is gone forever.

This isn't another human-soldier shooter. It's a game about **machines fighting machines**, where:

- **Two health systems**: mechanical durability + signal strength (remote control link). Either hitting zero = death.
- **Computing power** is a shared team resource — hack, jam, counter-hack. Teammates share a computing pool.
- **Dynamic map modeling** — scan the environment to permanently unlock wireframe 3D maps. Mark locations. State changes reveal enemy presence.
- **A living factory ecosystem** — the map itself is an automated production line: mines → smelters → factories → shipping depots. Interact with every link in the chain.

## Current Status

**Early prototype.** Playable test arena with FPS movement, shooting, enemies. Actively seeking contributors.

Built on [Kenney's Starter Kit FPS](https://github.com/KenneyNL/Starter-Kit-FPS) (CC0 assets) with:
- Animated AK-74M weapon model (PBR, 8 keyframe animations)
- Dual health-bar HUD (mechanical durability + signal strength)
- Energy bar system with signal decay over time
- Minimap system (follow/lock modes)

## Quick Start

```bash
# Clone the project
git clone https://github.com/Player-2048/RoboShooter.git
cd RoboShooter

# Open in Godot 4.6+
# Run scenes/main.tscn
```

**Requirements:** [Godot 4.6](https://godotengine.org/) or later.

## Tech Stack

| Category | Choice |
|----------|--------|
| Engine | Godot 4.6 |
| Language | GDScript |
| VCS | Git & GitHub |
| License | MIT |
| Assets | CC0 (Kenney) + CC-BY-4.0 (models) |

## Project Structure

```
RoboShooter/
├── README.md / README-zh.md    # Bilingual readme
├── LICENSE                     # MIT
├── devlog.md / devlog-en.md    # Development log
├── docs/
│   ├── game-design-doc.md      # Full Chinese design doc
│   ├── game-design-doc-en.md   # English condensed version
│   └── design.md               # Original outline
├── scenes/     scripts/        # Godot scene & script files
├── assets/     prototypes/     # Art assets & web prototypes
└── weapons/    objects/        # Weapon resources & game objects
```

## Roadmap

- [x] Project init, MIT license
- [x] Game design document (14 systems, 10+ facilities)
- [x] Working prototype (FPS movement, shooting, enemies, HUD)
- [ ] Weapon system: reload, ammo, multiple weapon types
- [ ] Robot selection & skill system
- [ ] Map modeling system (wireframe god-view)
- [ ] Hacking & computing power mechanics
- [ ] Multiplayer networking
- [ ] Full mine map with all 10 facilities

## Why Contribute?

- **Novel game design** — robot extraction shooter is an untapped genre space
- **100% GDScript** — easy to read, modify, and extend
- **CC0 assets included** — you can build and test immediately
- **Detailed design docs** — 14-system specification with mechanics explained
- **Beginner-friendly codebase** — small, well-structured, actively documented

## How to Contribute

1. Check [Issues](https://github.com/Player-2048/RoboShooter/issues) for tasks
2. Read `docs/game-design-doc-en.md` for the full vision
3. Fork → branch → PR
4. Join the discussion

**All contributions welcome** — code, art, sound, design feedback, documentation.

---

> "I'm a programming beginner. I handle the ideas and testing. AI writes the code. GitHub brings the collaborators."
> — Player-2048, project creator
