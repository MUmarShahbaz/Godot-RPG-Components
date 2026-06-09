extends Area2D
## Spawns Scene as siblings continously in intervals with the option to have multiple spawns in the run.
## The scene is spawned in a random location inside any of the [CollisionShape2D] children.[br][br]
## [b]Warning[/b]: If any [CollisionShape2D] is not a [RectangleShape2D], it will be ignored.
class_name AreaSpawner

## Lists all children at runtime. Only these will be used used to determine location.
## You should manually refresh this if you want to dynamically generate any [CollisionShape2D].
@onready var all_children : Array[Node] = get_children()

## The scenes to spawn. A Random scene will be picked from here to be spawned.
@export var Scenes : Array[PackedScene]
## When set to [code]true[/code], it will automatically begin spawning as soon as it enters the tree.
@export var autostart : bool = false
@export_group("Continous")
## Scenes spawned per Second.
@export var Rate: float = 0.5
@export_group("Once")
## Number of scenes spawned at the very first run.
@export var Initial_Spawns : int = 10

func _ready():
	monitoring = false
	monitorable = false
	if autostart: begin.call_deferred()

## The time passed since the last spawn.
var time_counter : float
## A boolean to turn spawning on and off.
var spawning : bool = false

func _physics_process(delta: float) -> void:
	if spawning:
		time_counter += delta
		if time_counter >= 1/Rate:
			time_counter = 0
			spawn()

## Start spawning.
func begin():
	for i in Initial_Spawns:
		spawn()
	if Rate == 0: queue_free()
	spawning = true

## Stop spawning and self-destruct. To pause spawning, simply set [param spawning] to [code]false[/code].
func end():
	spawning = false
	queue_free.call_deferred()

## The spawn function, use this to randomly spawn a scene from the [param Scenes] array.
func spawn():
	var spawn_regions = all_children.filter(func (x): return x is CollisionShape2D and x.shape is RectangleShape2D)
	var this_region : CollisionShape2D = spawn_regions.pick_random()
	var extents : Vector2 = (this_region.shape as RectangleShape2D).extents
	var local_random_position : Vector2 = Vector2(randf_range(-extents.x, extents.x), randf_range(-extents.y, extents.y))
	var scene_to_spawn : PackedScene = Scenes.pick_random()
	var new_scene : Node2D = scene_to_spawn.instantiate()
	new_scene.global_position = this_region.to_global(local_random_position)
	add_sibling.call_deferred(new_scene, true)
