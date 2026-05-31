extends Node
## A [Projectile] launcher. Suited (but not limited) to long-range or Projectile attacks.[br]
## This node is Frame-Synced.
class_name ProjectileAttack

## Emitted when the attack is activated.
signal attacked
## Emitted when an [Entity] gets hit by the attack.
signal hit(entity : Entity, damage_amount : float)

@export_group("Projectile", "PR")
## The [Projectile] that will be shot from this attack.
@export var PR_Projectile_Scene : PackedScene
## The offset of the [Projectile]'s center from the parent/shooter's center when the projectile is spawned while the character is facing right.[br]
## This will automatically be horizontally flipped if [param PR_Direction] is [code]-1[/code].
@export var PR_Offset : Vector2
## The direction in which to shoot the projectile.[br]
## Intended value is [code]1[/code] or [code]-1[/code]. Only the sign of the value will be considered.
@export var PR_Direction : int
## The Force with which to shoot the [Projectile] if the character is facing right.[br]
## This will automatically be horizontally flipped by the [Projectile] itself if [param PR_Direction] is [code]-1[/code].
@export var PR_Force : Vector2
## Force overwrite damage on launched projectiles. Leave it as [code]NAN[/code] to use the projectile's inate value.
@export var Damage : float = NAN
## A multiplier to increase applied damage exponentially.[br]
## Useful for power-ups.
@export var Multiplier : float = 1.0
## Cooldown to temporarily disable Frame-Sync.
@export var Cooldown : bool = false
## All Layers which can be [b]hit[/b] by this attack (including characters).[br]
## This is carried forward to the [Projectile].
@export_flags_2d_physics var obstruction_layers: int = 1
@export_group("Frame Sync", "FS")
## Name of the Animation which will automatically trigger this attack.
@export var FS_Animation : String = ""
## Frame at which the [Projectile] is spawned.
@export var FS_Spawn_Frame : int = 0
## Frame at which the [Projectile] is launched.
@export var FS_Launch_Frame : int = 0
@export_group("Audio", "AUX")
## [AudioStreamPlayer2D] to play when the attack animation begins.
@export var AUX_On_Animation_Start : AudioStreamPlayer2D
## [AudioStreamPlayer2D] to play when the spawn frame is reached.
@export var AUX_On_Spawn_Frame : AudioStreamPlayer2D
## [AudioStreamPlayer2D] to play when the launch frame is reached.
@export var AUX_On_Launch_Frame : AudioStreamPlayer2D

## The parent of this node.
@onready var parent : Node2D = get_parent()
## A boolean to tell whether the attack is currently in progress or not.
var attacking : bool = false

#region Core
func _process(delta: float) -> void:
	if Cooldown: return
	if parent.check_anim(FS_Animation):
		if not attacking:
			attacking = true
			if AUX_On_Animation_Start: AUX_On_Animation_Start.play()
	else: attacking = false
	if parent.check_frame(FS_Animation, FS_Spawn_Frame):
		if AUX_On_Spawn_Frame: AUX_On_Spawn_Frame.play()
		spawn()
	if parent.check_frame(FS_Animation, FS_Launch_Frame):
		attacked.emit()
		if AUX_On_Launch_Frame: AUX_On_Launch_Frame.play()
		launch()
#endregion

## Variable to hold the last spawned [Projectile]
var new_projectile : Projectile

## Spawn sequence for the [Projectile]
func spawn(damage : float = Damage):
	if new_projectile: await new_projectile.queue_free()
	new_projectile = PR_Projectile_Scene.instantiate()
	new_projectile.global_position = parent.global_position + Vector2(PR_Offset.x * signi(PR_Direction), PR_Offset.y)
	new_projectile.dir = signi(PR_Direction)
	new_projectile.Damage = new_projectile.Damage*Multiplier if is_nan(damage) else damage*Multiplier
	new_projectile.collision_mask = obstruction_layers
	get_tree().get_current_scene().add_child(new_projectile)

## Launch sequence for the [Projectile].[br]
## Force direction is automatically fixed by the [Projectile].
func launch(force : Vector2 = PR_Force): if new_projectile: new_projectile.launch(force)
