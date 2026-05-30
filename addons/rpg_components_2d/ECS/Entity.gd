extends CharacterBody2D

## Base Class for all 2D Entities. It contains character stats and meta data.
## [br]
## Handles core logic including:[br]
## - [i]Gravity[/i][br]
## - [i]Face Direction (and a fixed Container for RayCasts)[/i][br]
## - [i]Hitpoints[/i][br]
## - [i]Movement[/i][br]
## - [i]Animation Control[/i][br]
## - [i]Basic Audio[/i][br]
class_name Entity

#region Character Stats
## The type of a character an entity can be
enum character_type {
	## Hero Character
	Hero,
	## Ally of the Hero Character
	Ally,
	## Neutral Character
	Civillian,
	## Minions of the Enemy Boss
	Enemy,
	## Enemy Boss
	Boss
}

## Main Attack type of the character
enum attack_type {
	## Cannot Attack
	None,
	## Uses Melee attacks mainly
	Melee,
	## Uses Projectile attacks mainly
	Projectile
}

## A Picture of the Character[br]
## Useful for creating character cards and HUD icons
@export var avatar : Texture2D
## Name of the Character[br]
## Useful for creating character cards, HUD and character selector
@export var title : String
## Type of Entity the character is[br]
## Useful for creating character cards
@export var type : character_type
## Type of Attack the character mainly uses[br]
## Useful for creating character cards
@export var attack : attack_type
@export_group("Stats")
## Max HP that the character will have[br]
@export var Hit_Points : float
## The walking speed of the character[br]
@export var Walk_Speed : float
## The running speed of the character[br]
@export var Run_Speed : float
## The upwards velocity at which the character jumps[br]
@export var Jump_Velocity : float
## The attack range of the character[br][br]
## Useful for creating character cards
@export var Attack_Range : float
#endregion

#region Meta
## Emited when the character is spawned
signal spawned(Entity: Entity)
## Emited when the character walks or runs
signal moved(dir: float, run : bool)
## Emitted when the character jumps
signal jumped
## Emitted when the character is damaged
signal hurt(amount: float)
## Emitted when the character dies
signal died

@export_category("Meta")
## A Bool to disable gravity for this character
@export var gravity : bool = true
## A Bool to disable character's built-in AI
@export var puppet : bool = false
## A Reference to the [CollisionShape2D] of the character
@export var collider : CollisionShape2D
@export_group("Animation Names", "ANM_N")
## Animation Name for Walking[br]
@export var ANM_N_Walk : String
## Anmiation Name for Running[br]
@export var ANM_N_Run : String
## Animation Name for Jumping[br]
@export var ANM_N_Jump : String
## Animation Name for Hurting[br]
@export var ANM_N_Hurt : String
## Animation Name for Dying[br]
@export var ANM_N_Die : String
## A list of names of all animations that will automatically pause the characters movement[br]
@export var ANM_N_auto_pause_movement : Array
@export_group("Animation Player", "ANM_P")
## A Reference to the [AnimatedSprite2D] of the character
@export var ANM_P_Animated_Sprite : AnimatedSprite2D
## A Reference to the [AnimationPlayer] of the character
@export var ANM_P_Animation_Player : AnimationPlayer
## A Reference to the [AnimationTree] of the character
@export var ANM_P_Animation_Tree : AnimationTree
@export_group("Sound Effects", "SFX")
## A Reference to the [AudioStreamPlayer2D] to play when the character spawns
@export var SFX_Spawn : AudioStreamPlayer2D
## A Reference to the [AudioStreamPlayer2D] to play when the character walks
@export var SFX_Walk : AudioStreamPlayer2D
## A Reference to the [AudioStreamPlayer2D] to play when the character runs
@export var SFX_Run : AudioStreamPlayer2D
## A Reference to the [AudioStreamPlayer2D] to play when the character jumps
@export var SFX_Jump : AudioStreamPlayer2D
## A Reference to the [AudioStreamPlayer2D] to play when the character is hurt
@export var SFX_Hurt : AudioStreamPlayer2D
## A Reference to the [AudioStreamPlayer2D] to play when the character dies
@export var SFX_Die : AudioStreamPlayer2D

## Enable/Disable Warnings for missing Nodes
@export var show_warnings : bool = true

## Checks for missing node references/paths
func check_nodes():
	if not show_warnings: return
	var t = "%s (%s)" % [title if title != "" else "Untitled Entity", name]
	if not collider: push_warning("%s is missing a Collider" % t)
	if not ANM_P_Animated_Sprite: push_warning("%s is missing a ANM_P_Animated_Sprite" % t)
	else:
		if not ANM_P_Animated_Sprite.sprite_frames: push_warning("%s does not have any sprite frames" % t)
		else:
			if not anim_exists(ANM_N_Walk): push_warning("%s does not have any '%s' %s animation" % [t, ANM_N_Walk, "(Walk)"])
			if not anim_exists(ANM_N_Run):  push_warning("%s does not have any '%s' %s animation" % [t, ANM_N_Run,  "(Run)"])
			if not anim_exists(ANM_N_Jump): push_warning("%s does not have any '%s' %s animation" % [t, ANM_N_Jump, "(Jump)"])
			if not anim_exists(ANM_N_Hurt): push_warning("%s does not have any '%s' %s animation" % [t, ANM_N_Hurt, "(Hurt)"])
			if not anim_exists(ANM_N_Die):  push_warning("%s does not have any '%s' %s animation" % [t, ANM_N_Die,  "(Die)"])
	if not ANM_P_Animation_Player: push_warning("%s is missing a ANM_P_Animation_Player" % t)
	if not ANM_P_Animation_Tree: push_warning("%s is missing a ANM_P_Animation_Tree" % t)
	if not SFX_Spawn: push_warning("%s is missing a SFX_Spawn" % t)
	if not SFX_Walk: push_warning("%s is missing a SFX_Walk" % t)
	if not SFX_Run: push_warning("%s is missing a SFX_Run" % t)
	if not SFX_Jump: push_warning("%s is missing a SFX_Jump" % t)
	if not SFX_Hurt: push_warning("%s is missing a SFX_Hurt" % t)
	if not SFX_Die: push_warning("%s is missing a SFX_Die" % t)
#endregion

#region Core
## Current HP of the character
var hp : float
## A [Node2D] which always faces right regardless of the character's position or rotation[br]
## This is intended to be used as a container for RayCasts which need to be independant
var RayBox : Node2D
## The direction the character is facing
var facing : int = 1

func _ready() -> void:
	check_nodes()
	hp = Hit_Points
	RayBox = Node2D.new()
	add_child.call_deferred(RayBox)
	if SFX_Spawn: SFX_Spawn.play()
	spawned.emit(self)

func _physics_process(delta: float) -> void:
	if not is_on_floor() and gravity: velocity += get_gravity() * delta
	if velocity.x != 0: velocity.x = move_toward(velocity.x, 0, delta*10)
	move_and_slide()

## Changes the direction the character is currently facing
func flip() -> void:
	facing *= -1
	scale.x *= -1
	RayBox.scale.x = facing
#endregion

#region Movement
## A Boolean to forcefully pause character movement
var force_pause : bool = false

## Checks whether or not movement should be paused at the current moment
func pause_movement() -> bool:
	var is_paused := false
	if force_pause: is_paused = true
	for anim in ANM_N_auto_pause_movement: if check_anim(anim): is_paused = true
	if is_paused: velocity.x = 0
	return is_paused

## Temporarily forces a pause on character movement
func quick_pause(duration : float = 0.3) -> void:
	force_pause = true
	await get_tree().create_timer(duration).timeout
	force_pause = false

## Used to move the character by making it walk/run
func move(x_dir : float, run : bool = false) -> void:
	if x_dir * facing < 0 : flip()
	if pause_movement(): return
	var delta = get_physics_process_delta_time()
	if x_dir != 0:
		if run:
			velocity.x = x_dir * Run_Speed * delta * 60
			if is_on_floor():
				start_anim(ANM_N_Run)
				moved.emit(x_dir, true)
				if SFX_Run: SFX_Run.play()
				if SFX_Walk: SFX_Walk.stop()
		else:
			velocity.x = x_dir * Walk_Speed * delta * 50
			if is_on_floor():
				start_anim(ANM_N_Walk)
				moved.emit(x_dir, false)
				if SFX_Run: SFX_Run.stop()
				if SFX_Walk: SFX_Walk.play()
	else:
		velocity.x = 0
		if SFX_Run: SFX_Run.stop()
		if SFX_Walk: SFX_Walk.stop()

## Makes the character jump
func jump(force := Jump_Velocity) -> void:
	if pause_movement() or not is_on_floor() or check_anim(ANM_N_Jump): return
	velocity.y -= force
	quick_pause(0.01)
	start_anim(ANM_N_Jump)
	if SFX_Jump: SFX_Jump.play()
	jumped.emit()
#endregion

#region HP
## Instantly kills the characters
func kill() -> void:
	damage(hp)

## Applies damage to the character
func damage(amount: float) -> void:
	if hp <= 0: return
	hp -= amount
	velocity.x = 0
	if hp <= 0: _die()
	else:
		start_anim(ANM_N_Hurt, true)
		if SFX_Hurt: SFX_Hurt.play()
		hurt.emit(amount)

## Procedure for when the character dies
func _die():
	set_process(false)
	set_physics_process(false)
	velocity.x = 0
	name = str(title + "-dead_" + str(randi()))
	collider.set_deferred("disabled", true)
	if SFX_Die:
		SFX_Die.play()
		force_anim(ANM_N_Die)
		await get_tree().create_timer(max(SFX_Die.stream.get_length(), ANM_P_Animation_Player.get_animation("die").length), false).timeout
	else: await force_anim(ANM_N_Die)
	died.emit()
	queue_free()
#endregion

#region ANM
## Checks if an animation is available
func anim_exists(animation : String) -> bool:
	return ANM_P_Animated_Sprite.sprite_frames.has_animation(animation)

## Checks if an animation is currently playing
func check_anim(animation : String) -> bool:
	if not ANM_P_Animated_Sprite: return false
	return ANM_P_Animated_Sprite.animation == animation

## Checks if a certain frame is currently playing
func check_frame(animation : String, frame : int) -> bool:
	if not ANM_P_Animated_Sprite: return false
	return ANM_P_Animated_Sprite.animation == animation and ANM_P_Animated_Sprite.frame == frame

## Checks if an animation is currently at it's last frame
func check_anim_end(animation : String) -> bool:
	if not ANM_P_Animated_Sprite: return false
	return ANM_P_Animated_Sprite.animation == animation and ANM_P_Animated_Sprite.frame == ANM_P_Animated_Sprite.sprite_frames.get_frame_count(animation) - 1

## Waits until a certain frame starts playing
func await_frame(animation: String, frame : int) -> void:
	while !check_frame(animation, frame):
		if not get_tree(): break
		await get_tree().process_frame
	return

## Waits until a certain animation ends
func await_anim_end(animation: String) -> void:
	while not check_anim_end(animation):
		if not get_tree(): break
		await get_tree().process_frame
	return

## Triggers a travel to an animation or forcefully jumps to it
func start_anim(animation : String, force : bool = false) -> void:
	if not ANM_P_Animation_Tree: return
	if force: ANM_P_Animation_Tree.get("parameters/playback").start(animation)
	else: ANM_P_Animation_Tree.get("parameters/playback").travel(animation)

## Forcefully starts an animation and waits till the end
func force_anim(animation : String) -> void:
	while not check_anim_end(animation):
		if not check_anim(animation): start_anim(animation, true)
		if not get_tree(): break
		await get_tree().process_frame
	return
#endregion
