extends Area2D
## A Class that can cause damage to any [Entity] inside a certain area. Suited (but not limited) to close-range or Melee attacks.[br]
## This node is Frame-Synced.
class_name MeleeAttack

## The available modes which can be used to modify how damage is applied.
enum DAMAGE_MODE {
	## Damage only the first [Entity] in the order in tree.
	FIRST,
	## Damage only the [Entity] whose [b]center[/b] is physically closest.
	CLOSEST,
	## Damage all [Entity] within the area with the full [param Damage].
	ALL,
	## Distributes the [param Damage] equally to all [Entity] within the area.
	DISTRIBUTED
}

## Emitted when the attack is activated.
signal attacked
## Emitted when an [Entity] gets hit by the attack.
signal hit(entity : Entity, damage_amount : float)

## The selected [enum DAMAGE_MODE].
@export var Mode : DAMAGE_MODE
## The default damage amount.
@export var Damage : float = 0
## A multiplier to increase applied damage exponentially.[br]
## Useful for power-ups.
@export var Multiplier : float = 1.0
## Cooldown to temporarily disable Frame-Sync.
@export var Cooldown : bool = false
## All Layers which will [b]block[/b] this attack.
@export_flags_2d_physics var obstruction_layers: int = 1
@export_group("Frame Sync", "FS")
## Name of the Animation which will automatically trigger this attack.
@export var FS_Animation : String = ""
## Frame at which the damage is applied.
@export var FS_Hit_Frame : int = 0
@export_group("Audio", "AUX")
## [AudioStreamPlayer2D] to play when the attack animation begins.
@export var AUX_On_Animation_Start : AudioStreamPlayer2D
## [AudioStreamPlayer2D] to play when the hit frame is reached and damage is applied.
@export var AUX_On_Hit_Frame : AudioStreamPlayer2D

## The parent of this node.
@onready var parent : Entity = get_parent()
## The [RayCast2D] used to check for obstructioncs.
@onready var ray := RayCast2D.new()
## A boolean to tell whether the attack is currently in progress or not.
var attacking : bool = false
## A boolean to tell whether or not damage was applied during the hit frame. Becomes true only after the hitframe has passed.
var hitting: bool = false

#region Core
func _ready() -> void:
	await parent.ready
	ray.enabled = false
	ray.collision_mask = obstruction_layers
	parent.RayBox.add_child.call_deferred(ray)

func _process(delta: float) -> void:
	if Cooldown: return
	if parent.check_anim(FS_Animation):
		if not attacking:
			attacking = true
			if AUX_On_Animation_Start: AUX_On_Animation_Start.play()
	else:
		attacking = false
		hitting = false
	if parent.check_frame(FS_Animation, FS_Hit_Frame) and not hitting:
		hitting = true
		attacked.emit()
		if AUX_On_Hit_Frame: AUX_On_Hit_Frame.play()
		damage()

## Checks whether anything in between is blocking the attack.
func obstruction_check(target : Entity) -> bool:
	ray.target_position = target.global_position - self.global_position
	ray.force_raycast_update()
	if ray.is_colliding() : return true
	else : return false
#endregion

#region Damager
## Applies damage based on the selected [enum DAMAGE_MODE].
func damage(amount : float = Damage*Multiplier):
	match Mode:
		DAMAGE_MODE.FIRST: damage_first(amount)
		DAMAGE_MODE.CLOSEST: damage_closest(amount)
		DAMAGE_MODE.ALL: damage_all(amount)
		DAMAGE_MODE.DISTRIBUTED: damage_distributed(amount)

## Applies damage to only the first [Entity] in the order in tree.
func damage_first(amount : float = Damage*Multiplier):
	ray.enabled = true
	for body in get_overlapping_bodies():
		if body is not Entity or obstruction_check(body) or body == parent: continue
		body.damage(amount)
		hit.emit(body, amount)
		break
	ray.enabled = false

## Applies damage to only the [Entity] whose [b]center[/b] is physically closest.
func damage_closest(amount : float = Damage*Multiplier):
	ray.enabled = true
	var closest : Entity = null
	for body in get_overlapping_bodies():
		if body is not Entity or obstruction_check(body) or body == parent: continue
		if closest == null: closest = body
		else:
			if to_local(closest.global_position).length() > to_local(body.global_position).length():
				closest = body
	closest.damage(amount)
	hit.emit(closest, amount)
	ray.enabled = false

## Applies damage to all [Entity] within the area with the full [param Damage].
func damage_all(amount : float = Damage*Multiplier):
	ray.enabled = true
	for body in get_overlapping_bodies():
		if body is not Entity or obstruction_check(body) or body == parent: continue
		body.damage(amount)
		hit.emit(body, amount)
	ray.enabled = false

## Applies equally distributed damage to all [Entity] within the area.[br]
## The sum of all damages is equal to [param amount], which by default is [code]Damage * Multiplier[/code].
func damage_distributed(amount : float = Damage*Multiplier):
	ray.enabled = true
	var victims : Array = []
	for body in get_overlapping_bodies():
		if body is not Entity or obstruction_check(body) or body == parent: continue
		victims.append(body)
	ray.enabled = false
	for this_victim in victims:
		this_victim.damage(amount/victims.size())
		hit.emit(this_victim, amount)
#endregion
