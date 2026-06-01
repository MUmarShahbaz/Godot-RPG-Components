# RPG Components 2D

## Catalogue

|         Class         |     Inherits      | Description                                                                                                                                                                                                  |
| :-------------------: | :---------------: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `CharacterController` |      `Node`       | A Template Class for low-level & Controller-Specific input handling to control a character.                                                                                                                  |
|    `DynamicEntity`    |     `Entity`      | A variant of Entity with a Mass. This variant can resolve central forces and central impulses.                                                                                                               |
|       `Entity`        | `CharacterBody2D` | Base Class for all 2D Entities. It contains character stats, meta data and handles core logic such as HP and Movement.                                                                                       |
|      `Explosive`      |     `Area2D`      | A circular area which applies an impulse to all PhysicsBody2D inside of it; applies damage to all Entity inside of it; self-destructs at the end.                                                            |
|     `MeleeAttack`     |     `Area2D`      | A Class that can cause damage to any Entity inside a certain area. Suited (but not limited) to close-range or Melee attacks.                                                                                 |
|     `Projectile`      |   `RigidBody2D`   | A shootable element that causes damage to Entity on impact and self-destucts. Can be shot using a ProjectileAttack. If it hits anything other than an Entity, it will self-destruct without applying damage. |
|  `ProjectileAttack`   |      `Node`       | A Projectile launcher. Suited (but not limited) to long-range or Projectile attacks. This node is Frame-Synced.                                                                                              |
|    `SmoothCamera`     |    `Camera2D`     | A Camera which moves smoothly with the target.                                                                                                                                                               |