extends Camera2D
## A Camera which moves smoothly with the target.[br][br]
## [b]Warning[/b]: The Camera may appear buggy on high refresh rate displays due to a mismatch between physics and process frames.[br]
## Process Frames run at your display frequency but Physics Frame (by default) run at a fixed 60Hz[br]
## [br]
## Consider turning [i]Physics Interpolation[/i] ON in the project settings or try manually alligning the two.
class_name SmoothCamera

## The target which the camera will follow.
var target: Node2D
## Weightage for [code]lerp()[/code].[br]
## [b]Note[/b]: The most significant smoothing happens when this value is less than 0.1
@export_range(0.0, 1.0, 0.001) var smoothing: float = 0.05
## The distance between the camera center and the target in pixels when the [param offset_value] is [code]Vector2(1, 1)[/code] 
@export var offset_unit: Vector2
## The value of offset. This is expected to be normalized but the code will still work if it is not.
## You can also use bigger vectors to offset the camera more than the [param offset_unit].[br][br]
## Final offset is calculated by [code] offset = offset_unit * offset_value [/code]
var offset_value: Vector2 = Vector2.ZERO

func _ready() -> void:
	limit_smoothed = true
	position_smoothing_enabled = true

func _process(_delta: float) -> void:
	if target:
		global_position = lerp(global_position, target.global_position + offset_value, smoothing)

## Set value for the parameter [param offset_value]
func set_target_offset(new_offset: Vector2):
	offset_value.x = new_offset.x * offset_unit.x
	offset_value.y = new_offset.y * offset_unit.y
