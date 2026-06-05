extends Node
## A Template Class for low-level & Controller-Specific input handling to control a character.[br]
## All methods are intended to be overwritten in a child class with your own custom settings.
class_name CharacterController

## The Character to be controlled
@onready var Character : Entity = get_parent()
## Visuals
@onready var CAM := SmoothCamera.new()
## Audio
@onready var EAR := AudioListener2D.new()
## The Controller from which input will be accepted[br]
## All other input devices will be ignored
@export var my_controller = DEFAULT_DEVICE

## A Constant representing the id of the default device
const DEFAULT_DEVICE = -1

#region Core
func _ready() -> void:
	prepare_audio_and_video()
	set_controller()

func _unhandled_input(event: InputEvent) -> void:
	if my_controller != DEFAULT_DEVICE && my_controller == event.device: _gamepad_input(event)
	else: _default_input(event)

func _process(delta: float) -> void:
	if my_controller != DEFAULT_DEVICE: _poll_gamepad_input(delta)
	else: _poll_default_input(delta)
#endregion

#region Prepare Audio and Video
## A function to set up an AudioListener2D & Camera
func prepare_audio_and_video():
	CAM.target = Character
	CAM.offset_unit = Vector2(160, 90)
	add_child.call_deferred(CAM)
	add_child.call_deferred(EAR)
	CAM.make_current.call_deferred()
	EAR.make_current.call_deferred()
#endregion

#region Controller Selector
## A Function to select which controller will be used[br]
## Use the RPG_2D_CONTROLLERS singleton to get all connected controllers
func set_controller() -> void: return
#endregion

#region Triggerable Inputs
## A Function to handle Input Events triggered by a gamepad[br]
## This function is only called if the event was triggered by the selected controller[br]
func _gamepad_input(event: InputEvent):
	if event is InputEventJoypadButton:
		match event.button_index:
			JOY_BUTTON_A: if event.is_pressed(): Character.jump()

## A Function to handle Input Events triggered by the default device (e.g: KeyBoard) [br]
## This function is only called if the event was triggered by the selected controller[br]
func _default_input(event: InputEvent):
	if event is InputEventKey:
		match event.physical_keycode:
			KEY_SPACE: if event.is_pressed(): Character.jump()
#endregion

#region Continous Inputs
## A Function to handle inputs from a gamepad continously instead of triggers[br]
## This function is only called if the selected controller is not the default device[br]
## Input is not filltered to the selected controller automatically
func _poll_gamepad_input(_delta : float) -> void:
	var x_dir = Input.get_joy_axis(my_controller, JOY_AXIS_LEFT_X)
	var run = Input.get_joy_axis(my_controller, JOY_AXIS_TRIGGER_RIGHT) > 0.5
	Character.move(x_dir, run)

## A Function to handle inputs from the default continously instead of triggers[br]
## This function is only called if the selected controller is the default device
func _poll_default_input(_delta : float) -> void:
	var x_dir = 0
	var run = false
	if Input.is_physical_key_pressed(KEY_A) or Input.is_physical_key_pressed(KEY_LEFT): x_dir -= 1
	if Input.is_physical_key_pressed(KEY_D) or Input.is_physical_key_pressed(KEY_RIGHT): x_dir += 1
	run = Input.is_physical_key_pressed(KEY_SHIFT)
	Character.move(x_dir, run)
#endregion
