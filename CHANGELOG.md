# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-06-04

### Added
- New Node: `CharacterController`
- New Node: `DynamicEntity`
- New Node: `Entity`
- New Node: `Explosive`
- New Node: `MeleeAttack`
- New Node: `ProjectileAttack`
- New Node: `Projectile`
- New Node: `SmoothCamera`
- New Singleton: `RPG_2D_Controllers`

## [1.0.1] - 2026-06-08

### Chnaged
- Movement of `Entity` is now separate from velocity (`Entity` **accelerates** towards output of `move()`)
- Addon Icon

### Fixed
- Explosive can safely explode even with only one of `Impulse` or `Damage`
- Animation Helpers on `Entity`
- `MeleeAttack` from harming the user
- Direction handling on `Projectile` and `ProjectileAttack`

## [1.1.0] - 2026-06-09

### Added
- New Node: `PointSpawner`
- New Node: `AreaSpawner`
- New Node: `Buffer`