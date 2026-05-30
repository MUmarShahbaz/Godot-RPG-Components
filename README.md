# RPG Components 2D

## Catalogue

| Class      | Inherits          | Description |
|:----------:|:-----------------:|:------------|
| `CharacterController` | `Node` | A Template Class for low-level & Controller-Specific input handling to control a character. |
| `Entity`   | `CharacterBody2D` | Base Class for all 2D Entities. It contains character stats, meta data and handles core logic such as HP and Movement. |
| `MeleeAttack` | `Area2D` | A Class that can cause damage to any Entity inside a certain area. Suited (but not limited) to close-range or Melee attacks. |
| `SmoothCamera` | `Camera2D` | A Camera which moves smoothly with the target. |