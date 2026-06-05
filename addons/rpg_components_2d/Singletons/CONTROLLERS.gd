extends Node
## This Singleton automatically creates a list off all connected controllers and automatically changes the light color of any newly connected controllers

## List of connected controllers.[br]
## [b]Note[/b]: [code]Controller[0][/code] is the default device (eg. KeyBoard/Mouse) and all others are gamepads.[br][br]
## The dicionary contains:[br]
## - [code]id[/code]: Device number ([code]-1[/code] means default device)[br]
## - [code]name[/code]: Device name as a string[br]
## - [code]has_light[/code]: Boolean for whether or not the controller has a light[br]
## - [code]light[/code]: The color of the light ([code]0[/code] means there is no light, otherwise the value is of type [Color][br]
var Controllers : Array[Dictionary] = [{
	"id": -1,
	"name": "Default",
	"has_light": false,
	"light": 0
}]

func _ready() -> void:
	Input.joy_connection_changed.connect(_joy_changed)

func _joy_changed(device: int, connected: bool):
	if connected:
		var info : Dictionary = {}
		info.set("id", device)
		info.set("name", Input.get_joy_name(device))
		var has_light = Input.has_joy_light(device)
		info.set("has_light", has_light)
		if has_light:
			var light = _player_color(Controllers.size())
			Input.set_joy_light(device, light)
			info.set("light", light)
		else: info.set("light", 0)
		Controllers.append(info)
	else:
		var index = Controllers.find_custom(func (x: Dictionary): return x.get("id") == device)
		Controllers.remove_at(index)

#region Light
## Change a controller's light through here so that the [param Controllers] array stays updated.
func change_light(device: int, color: Color):
	Input.set_joy_light(device, color)
	var index = Controllers.find_custom(func (x: Dictionary): return x.get("id") == device)
	Controllers[index].set("light", color)

func _player_color(player_num: int) -> Color:
	var n = player_num - 2
	var level = 0
	var count = 1
	while n > count:
		n -= count
		count *= 2
		level += 1
	var k = n - 1
	var denom = pow(2, level + 1)
	var result = float(2 * k + 1) / float(denom)

	if player_num == 1: result = 0.0
	if player_num == 2: result = 1.0
	return Color.from_hsv(lerp(0.0, 0.666, result), 1.0, 1.0)
#endregion
