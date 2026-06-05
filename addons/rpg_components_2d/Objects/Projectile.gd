extends RigidBody2D
## A shootable element that causes damage to [Entity] on impact and self-destucts. Can be shot using a [ProjectileAttack].[br]
## If it hits anything other than an [Entity], it will self-destruct without applying damage.
class_name Projectile

## The damage applied on the [Entity] hit.
@export var Damage : float
## The [AudioStreamPlayer2D] to play when something is hit.
@export var Hit_SFX : AudioStreamPlayer2D
## The direction in which the [Projectile] is being hit.
var dir : int

#region Core
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	if dir == -1 : flip()
	while true:
		await get_tree().create_timer(1).timeout
		if timeout(): self_destruct(true)

func _physics_process(_delta: float) -> void:
	var bodies = get_colliding_bodies()
	if bodies.size() > 0:
		if bodies[0] is Entity: hit(bodies[0])
		self_destruct()

## A function to change the direction (but not the force) of the [Projectile].
func flip(): scale.x *= -1
#endregion

## A function to self-destruct if the projectile hasn't hit something.[br]
## Overwrite to use your own custom check.
func timeout() -> bool:
	return abs(linear_velocity.x) < 100

## The Self-Destruct sequence. Overwrite to define your own sequence.
func self_destruct(mute: bool = false):
	if not mute and Hit_SFX:
		hide()
		set_process(false)
		set_physics_process(false)
		Hit_SFX.play()
		await get_tree().create_timer(Hit_SFX.stream.get_length() + 0.1).timeout
	queue_free()

## A function to launch the projectile.[br]
## Can be overwritten.
func launch(force : Vector2) -> void: apply_impulse(force)

## A function that is called when an [Entity] is hit.
func hit(entity : Entity):
	entity.damage(Damage)
	entity.velocity.x += 10*dir
