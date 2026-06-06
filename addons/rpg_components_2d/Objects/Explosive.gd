extends Area2D
## A circular area which:[br]
## - Applies an impulse to all [PhysicsBody2D] inside of it.[br]
## - Applies damage to all [Entity] inside of it.[br]
## - Self-destructs at the end.
class_name Explosive

## A [CollisionShape2D] to use for calculating radius. This [b]MUST[/b] have a [CircleShape2D] selected.
@onready var Collider: CollisionShape2D = get_children().filter(func (x):return x is CollisionShape2D)[0]
## The [Node] to [code]queuefree()[/code] after exploding
@export var RootNode : Node = self
## The default mass to be assumed for [CharacterBody2D]s since they have no mass (excluding [DynamicEntity]).
@export var DefaultMass: float = 1.0
@export_group("Damage")
## The maximum amount of damage that can be applied on all victim [Entity].
@export var Damage: float
## A curve to define how much damage is applied depending on the victim's distance from the center of the [param Collider].
@export var Damage_Curve: Curve
@export_group("Impulse")
## The maximum amount of impulse that can be applied on all [PhysicsBody2D].
@export var Impulse: float
## A curve to define how much impulse is applied depending on the victim's distance from the center of the [param Collider].
@export var Impulse_Curve: Curve

## The function which triggers the explosion.
func explode():
	var shape : CircleShape2D = Collider.shape
	var bodies = get_overlapping_bodies().filter(func (x): return x is RigidBody2D or x is CharacterBody2D)
	for body in bodies:
		var disp : Vector2 = body.global_position - Collider.global_position
		var curve_x : float = clamp(disp.length() / shape.radius, 0, 1)
		if Damage and body is Entity: body.damage(Damage * Damage_Curve.sample(curve_x))
		if Impulse:
			var new_impulse : Vector2 = disp.normalized() * Impulse * Impulse_Curve.sample(curve_x)
			if body is RigidBody2D or body is DynamicEntity: body.apply_central_impulse(new_impulse)
			else: body.velocity += new_impulse / DefaultMass
	RootNode.queue_free()
