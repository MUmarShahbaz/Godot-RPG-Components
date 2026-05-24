@tool
extends EditorPlugin

var Singletons = [
	"DB",
	"CONTROLLERS"
]

func _enable_plugin() -> void:
	for singleton in Singletons: _handle_singleton(singleton, true)

func _disable_plugin() -> void:
	for singleton in Singletons: _handle_singleton(singleton, false)

func _enter_tree() -> void:
	print("Using RPG_COMPONENTS_2D")

func _exit_tree() -> void:
	pass

func _handle_singleton(name: String, enable: bool):
	if enable:
		if not ProjectSettings.has_setting("autoload/RPG_2D_" + name):
			add_autoload_singleton("RPG_2D_" + name, "res://addons/rpg_components_2d/Singletons/" + name + ".gd")
			print("Added Singleton: " + name)
	else:
		if ProjectSettings.has_setting("autoload/RPG_2D_" + name):
			remove_autoload_singleton("RPG_2D_" + name)
			print("Removed Singleton: " + name)
