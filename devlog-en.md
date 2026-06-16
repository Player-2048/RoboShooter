# Development Log (English)

> This document tracks key development milestones for future AI sessions and collaborators.
> Append after every major change.
> [中文版](devlog.md)

---

## 2026-06-15 | Project Restructuring & Tech Stack Migration

**Operator:** AI (Claude Code)

**Changes:**
- Tech stack changed from Unity + C# to **Godot 4.x + GDScript**
  - Rationale: GDScript is beginner-friendly; scene files are plain text (= AI-editable, Git-friendly); MIT license; free
- Updated `.gitignore` from Unity template to Godot template
- Updated `README.md` to reflect new tech stack and project structure
- Created `devlog.md` as AI-readable context log
- Consolidated scattered game design docs and web prototypes into this repository

**Project Status:**
- GitHub: https://github.com/Player-2048/RoboShooter
- Local path: `C:\Users\Admin\Desktop\RoboShooter`
- License: MIT

---

## 2026-06-16 (1) | Godot Project Init & Test Arena

**Operator:** AI (Claude Code) | **Godot version:** 4.5.1

**New files:**
- `project.godot` — Project config with input maps, physics, rendering
- `scripts/player_controller.gd` — First-person character controller
- `scenes/test_arena.tscn` — 200m×200m test arena

**Test arena contents:** Ground plane, procedural sky, directional light with shadows, 5 walls, 1 ramp, 5 height-graded platforms, weapon spawn marker

**FPS controller:** WASD movement, mouse look, space to jump, shift to sprint, ESC to toggle mouse capture

---

## 2026-06-16 (2) | Collision Fix + Arm Block + Minimap

**Operator:** AI (Claude Code)

**Collision fix:** All scene objects changed from CSGBox3D to StaticBody3D + CollisionShape3D + MeshInstance3D (CSG collisions were unreliable in headless mode).

**Arm block:** Minecraft-style rectangular pillar as camera child with walking bob animation.

**Circular minimap system:** `scripts/minimap.gd` — CanvasLayer-based. Two modes: view-follow (player always faces up, map rotates) and locked (north fixed, player arrow rotates). N key or button to toggle. Four corner position selector. Shows world objects, player arrow, N/E/S/W cardinal labels.

---

## 2026-06-16 (3) | AK-74M Model + Weapon System + Dual HUD

**Operator:** AI (Claude Code)

**Integrated from three repos:**
- Kenney Starter Kit FPS (base: enemies, sounds, scenes, weapon framework)
- FPS-Arms-3D by Ayush Mohanty (AK-74M with 8 keyframe animations, PBR materials)
- Jeh3no FPS Weapon System addon (recoil, muzzle flash, bullet decals, ammo, reload)

**New HUD system:** `scripts/hud.gd` — dual health bars (mechanical durability green bar + signal strength green→yellow→red bar), energy bar, signal decay over time, damage splits between health types.

**Player signals:** `health_updated`, `signal_updated`, `energy_updated` emitted from player controller.

---

## 2026-06-17 | Mine Map — 10 Facility Detailed Specs

**Operator:** AI (Claude Code) + User Q&A session

**Background:** The 10 mine facilities previously had only one-line descriptions. Through a structured Q&A session, each facility's operation mechanics, player interactions, and tactical value were fully detailed.

**Facilities documented:** Mining Machine, Mineral Transport Vehicle, Smelting Station, Processing Center, Deposit Station, Energy Center, Underground Transit, Central Control Room, Mechanical Repair Station, Sentinel Armory.

**AI recommended 5 new facilities:** Signal Relay Tower, Scrap Processing Yard, Staff Residential Zone, Sample Laboratory, Abandoned Extraction Point.

**Updated:** `docs/game-design-doc.md` section 8.1 fully rewritten, version bumped to 0.3.

---

## Early History (2025, Summary)

- GitHub repo RoboShooter created
- MIT License added
- Initial README written (originally planned Unity)
- Core design doc `机器人射击游戏设想.md` written, covering 8 major systems: map, exploration, hacker network, warehouse/crafting, robot, health, weapon, material transport
