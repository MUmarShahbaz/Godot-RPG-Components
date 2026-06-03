extends Entity
## A variant of [Entity] with a Mass. This variant can resolve central forces and central impulses.
class_name DynamicEntity

## Mass of the [DynamicEntity] in kg.
@export var Mass : float = 1.0
## Constant Forces being applied. Reset this with [code]constant_force = Vector2(0, 0)[/code] to remove all constant forces.
var constant_force : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if not is_on_floor() and gravity: apply_central_force(get_gravity())
	if velocity.x != 0: velocity.x = move_toward(velocity.x, 0, delta*10)
	if constant_force: apply_central_force(constant_force)
	move_and_slide()

## Adds a constant directional force without affecting rotation that keeps being applied over time until cleared with [code]constant_force = Vector2(0, 0)[/code].
func add_constant_central_force(force: Vector2): constant_force += force

## Applies a directional force without affecting rotation. A force is time dependent and meant to be applied every physics update.
func apply_central_force(force: Vector2): velocity += (force / Mass) * get_physics_process_delta_time()

## Applies a directional impulse without affecting rotation.[br][br]
## An impulse is time-independent! Applying an impulse every frame would result in a framerate-dependent force. For this reason, it should only be used when simulating one-time impacts (use the "_force" functions otherwise).
func apply_central_impulse(impulse: Vector2): velocity += impulse / Mass
