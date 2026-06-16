# RoboShooter — Game Design Document (English)

> Version 0.3 | 2026-06-17 | Condensed from full Chinese design doc
>
> [完整中文版](game-design-doc.md)

---

## Table of Contents

1. [Game Overview](#1-game-overview)
2. [Core Game Loop](#2-core-game-loop)
3. [Economy & Progression](#3-economy--progression)
4. [Health & Survival](#4-health--survival)
5. [Robot System](#5-robot-system)
6. [Weapon System](#6-weapon-system)
7. [Computing & Hacking](#7-computing--hacking)
8. [Map: Mine Facilities](#8-map-mine-facilities)
9. [Dynamic Map Modeling](#9-dynamic-map-modeling)
10. [Crafting & Warehouse](#10-crafting--warehouse)
11. [Team Mechanics](#11-team-mechanics)
12. [Audio Design](#12-audio-design)
13. [UI/HUD Architecture](#13-uihud-architecture)
14. [Expansion Systems](#14-expansion-systems)

---

## 1. Game Overview

**Genre:** Search-Fight-Extract (SFE) first-person shooter
**Core premise:** Players are remote operators controlling robot carriers sent into a fully-automated mining field. Nuclear fusion has solved energy scarcity — the real resource bottleneck is **materials and processing capability**.

**Key differentiators from traditional extraction shooters:**

| Traditional SFE | RoboShooter |
|----------------|-------------|
| Human operators in the field | Remote operators, robots are expendable carriers |
| Single health bar | Dual health: mechanical durability + signal strength |
| Inventory managed between matches | Manage everything in-match (craft, sell, repair, buy) |
| Fixed map knowledge | Dynamic map modeling, permanent unlocks across matches |
| Individual loot | Shared team backpack, cooperative profit |
| No computing concept | Shared computing pool, hacking attack/defense, control teammates' carriers |

---

## 2. Core Game Loop

### Pre-Match
1. Select map (Mine / Peacekeeping)
2. Matchmaking → squad formed (3-4 players)
3. **Preparation room ("locker room")**: Discuss team composition, robot choices, loadouts

### In-Match
- Loot, fight, complete objectives
- Access **built-in forum** for guides/intel
- Access **built-in shop** to pre-buy gear for next match
- **Craft, repair, smelt, dismantle** — all doable in-match without extracting first
- **Pre-sell** loot before extraction (locked in at extraction)

### Extraction
- Multiple extraction points, multiple types
- **Mandatory countdown**: signal interference increases over time, eventually disconnecting you
- Timer runs out → everything lost
- Full-team extraction NOT required — sacrifice plays are valid

### Death
- Robot body = gear you brought in. Destroyed = **permanently lost**.
- **Safety net**: free basic robots with dirt-cheap stats. Loot extracted with them gets partially deducted as payment ("unlimited credit, pay later").

---

## 3. Economy & Progression

- **Resource-backed currency**: Pegged to ore and blueprints, exchangeable at a fixed rate in-game
- **No wipes** — persistent progression
- **Processing capability as a commodity**: Low-tech players pay high-tech players to use better processing equipment
- **5 ways to acquire gear**: buy raw → craft → assemble; or buy parts directly; or buy finished gear; or loot in-match; or blueprint-based manufacturing
- **Secondary vault**: Protects core assets from being destroyed by borrowed accounts

---

## 4. Health & Survival

### Mechanical Durability (Health Bar)
- Robot body's physical integrity
- Display: humanoid silhouette with "draining water" style (like CrossFire bomb mode)
- Hits from enemy = durability damage + signal damage

### Signal Strength (Signal Bar)
- Remote control data link quality
- Display: scrolling diagonal-frame bar, green-white → yellow → red
- Decays over time (signal interference increases)
- Enemy hacking attacks also reduce signal
- Both bars hitting zero = death

### Energy (Mana Bar)
- Skill usage consumes energy
- Yellow bar, oil-textured, center-bottom of screen
- Replenishable via items and Energy Center facility

### Damage Feedback
- Hit direction inferred from body impact sensors (no hit markers)
- Metal-on-metal impact sound when hit
- Metal debris particles when enemy is hit (analogous to blood spray in human shooters)

---

## 5. Robot System

### Three Robot Types

**Humanoid Robot:**
- Inspired by Unitree robots, nuclear-powered
- All-rounder, balanced stats
- Can carry integrated payloads

**Alien-Type Robot:**
- Humanoid base + external modules
- Cyberpunk mechanical limb aesthetic
- More skill slots

**Joint-Distributed Robot:**
- Inspired by Iron Man's suit — parts can detach and fly independently
- Emergency escape: disassemble → scatter → reassemble
- Can possess AI robots to control enemies
- Signature skill: Separation Escape

### Key Design Principles
- **No light/medium/heavy classes** — robot stats depend on installed parts
- **All weapons universal** — any robot can use any weapon (like humans holding guns)
- **External modules = skills**: grappling hook, wall climbing, jump jets, etc.
- **Customization**: surface patterns via decals/sprays; full skin system TBD
- **Repair**: hot-swap damaged parts or use a portable repair kit (mini smelter that fabricates parts on demand)

---

## 6. Weapon System

### Gunpowder Firearms
- Traditional ballistic weapons
- Load cartridge → strike primer → fire projectile
- Magazine reload system

### Electromagnetic Weapons
- Charge weapon → accelerate shaped metal projectiles
- Ammo types:
  - **Metal jet** — armor-piercing
  - **Chemical corrosion** — damage over time
  - **Magnetic fragmentation** — shards embed in target, cumulative EM interference

### Weapon UI
- Bottom-right: weapon icon + ammo count (Apex Legends style)

---

## 7. Computing & Hacking

### What Costs Computing Power
- Hacking doors / locked containers (alternative to keycards)
- Activating facility equipment (turrets, alert systems)
- Infiltrating AI robots (plant false intel, create traps)
- Counter-hacking (defense)

### Signal Attack Effects
- Screen noise / visual distortion (data corruption on receiver end)
- Certain HUD functions disabled or degraded
- Signal bar visibly dropping

### Defense
- Spend computing power to neutralize attacks
- Reverse-hacking is extremely difficult — defense is the primary strategy
- Pre-processing scripts on the operator side filter out most audio interference

### Shared Computing Pool
- Each player contributes a portion of their computing power to a **team pool**
- Pool resources can be used by any teammate without asking
- No distance limit — all share the same data link
- Extreme case: **directly control a teammate's carrier**, use their equipment
- Dead teammate → spectator mode → "co-pilot" the living teammate's systems

---

## 8. Map: Mine Facilities

The mine is a **fully automated production ecosystem**. All 10 facilities form a complete industrial chain.

| # | Facility | Core Value | Player Interaction |
|---|----------|-----------|-------------------|
| 1 | **Mining Machine** | Produces raw ore | Destroy for parts / intercept ore on conveyor |
| 2 | **Mineral Transport** | Mobile high-value loot + AI escort | Destroy to stop → triggers "raid battle" with infinite AI reinforcements |
| 3 | **Smelting Station** | Ore → metal ingots (loot compression) | Compress 4-slot ore into 1-2 slot ingots / scavenge finished ingots |
| 4 | **Processing Center** | Ingots → parts → equipment + rare alloy synthesis | Craft / hack for unique items / loot storage room |
| 5 | **Deposit Station** | In-match instant loot cashout + delivery service | Deposit → guard timer → map-wide ping → PvP hotspot |
| 6 | **Energy Center** | Indestructible power hub + energy refill | Refill energy / scavenge batteries / disrupt power links |
| 7 | **Underground Transit** | Left-to-right map tunnel with infinite armory | Hack for ID disguise → fast cross-map travel |
| 8 | **Central Control** | AI mastermind, ultimate challenge | Hack → story item + crafting tier upgrade |
| 9 | **Repair Station** | Robot repair + heal, spare parts | Auto-repair (requires ID) / self-repair / scavenge rare modules |
| 10 | **Sentinel Armory** | Punishment-based map balancing | Low/High alert system, infinite reinforcement, parts are tracked (unlootable) |

### AI Recommended Additions
- **Signal Relay Tower** — boost signal strength in an area
- **Scrap Processing Yard** — low-value recycling, low risk
- **Staff Residential Zone** — environmental storytelling, blueprint fragments
- **Sample Laboratory** — rare ore analysis, blueprint identification
- **Abandoned Extraction Points** — randomized activation per match

---

## 9. Dynamic Map Modeling

- Player enters **scan mode** in an area → environment is 3D-modeled
- Special zones require task completion / hacking to unlock scanning
- Open god-view: **stripped-down wireframe 3D model** of scanned areas (like CS2 Dust2 whitebox)
- **Permanent unlock**: scanned areas persist across matches (Hollow Knight map system inspiration)
- **Scene state recording**: opened containers, door states, dead AI bodies are tracked
- Re-enter a scanned zone → state has changed → **marked red on map** = someone was here
- **Marking system**: place markers on god-view map → synced to first-person HUD
- Teammates share scan data and marks

---

## 10. Crafting & Warehouse

- Ore → smelt → metal ingot → process → parts → assemble → equipment
- **Blueprint system**: Equipment blueprints unlock part manufacturing recipes; hidden blueprints from special sources
- All crafting, repairing, smelting, dismantling doable **in-match**
- Pre-selling: lock in trade before extraction

---

## 11. Team Mechanics

- **Squad size**: 3 or 4 (possibly both as separate modes)
- **Shared backpack**: more teammates = more total capacity = more individual profit (anti-betrayal design)
- **Shared computing pool** (see Section 7)
- **Extraction**: Not everyone needs to extract. Rearguard sacrifices are valid. Loot is split post-match.
- **Communication**: Ping wheel + quick commands + fully customizable voice lines with style presets (male/female/robotic voices, optional BGM and sound effects for meme purposes)

### Open Problem
- How to prevent teammates from doing nothing and leeching shared loot?

---

## 12. Audio Design

- **Multi-surface footsteps**: metal, dirt, gravel — different sounds per material
- **Robot type audio**: different models have distinct movement sounds (for identification)
- **Mechanical noise does NOT propagate**: robot servo/hydraulic sounds are not heard by enemies (like CS2 weapon switching being silent)
- **Signal interference**: subtle static/noise when connection degrades (pre-processed client-side to minimize annoyance)
- **Combat**: metal-on-metal impact sounds; metal debris particle audio

---

## 13. UI/HUD Architecture

| Position | Element | Style |
|----------|---------|-------|
| Top-left | Mechanical durability | Humanoid silhouette, water-level style |
| Top-left | Signal strength | Scrolling diagonal frame, green-white→yellow→red |
| Center-bottom | Energy bar | Yellow, oil-textured |
| Center-bottom | Computing power | Glowing, subtle number effects |
| Bottom-right | Weapon + ammo | Apex Legends style |
| Top-right | Circular minimap | Follow/lock dual mode (prototype done) |
| Center | Crosshair | Dynamic, per-weapon |

### Additional UI
- Extraction countdown (signal degradation timer)
- Teammate status: health, signal, position
- Scan progress bar
- Hit direction indicator (body sensor-based, not minimap)
- Scene marker icons (god-view marks → first-person sync)

---

## 14. Expansion Systems

Mentioned in design notes but not yet fully detailed:

- Outpost system
- Virtual shooting range
- Computing currency system
- Skill tree
- Production factory
- Virtual battle royale map (hacker network sub-feature)
- Peacekeeping map (alternative to Mine)

---

> This document is maintained alongside the full Chinese version. For complete detail on any system, refer to [game-design-doc.md](game-design-doc.md).
