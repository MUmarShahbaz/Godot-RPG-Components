extends Camera2D
## A Camera which moves smoothly with the target.[br][br]
## [color=red]Warning[/color]: The Camera may appear buggy on high refresh rate displays due to a mismatch between physics and process frames.[br]
## Process Frames run at your display frequency but Physics Frame (by default) run at a fixed 60Hz[br]
## [br]
## Consider turning [i]Physics Interpolation[/i] ON in the project settings or try manually alligning the two.
class_name SmoothCamera

var target: CharacterBody2D
@export_range(0.0, 1.0, 0.01) var smoothing: float = 0.5
@export var offset_unit: Vector2
var offset_value: Vector2 = Vector2.ZERO

func _ready() -> void:
	limit_smoothed = true
	position_smoothing_enabled = true

func _process(_delta: float) -> void:
	if target:
		global_position = lerp(global_position, target.global_position + offset_value, smoothing)
	
func set_target_offset(new_offset: Vector2):
	offset_value.x = new_offset.x * offset_unit.x
	offset_value.y = new_offset.y * offset_unit.y
