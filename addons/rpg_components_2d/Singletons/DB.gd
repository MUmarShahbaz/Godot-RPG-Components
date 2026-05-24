@tool
extends Node

var edb := ConfigFile.new() # Entity Database
var adb := ConfigFile.new() # Ability Database

func _ready():
	refresh()

func refresh():
	var edb_check = edb.load("res://addons/rpg_components_2d/DB/entity.cfg")
	var adb_check = adb.load("res://addons/rpg_components_2d/DB/ability.cfg")
	if edb_check != OK: push_error("Failed to load Entity config file")
	if adb_check != OK: push_error("Failed to load Ability config file")

func edb_get(section: String, key: String, default = null):
	return edb.get_value(section, key, default)

func edb_set(section: String, key: String, value):
	edb.set_value(section, key, value)

func adb_get(section: String, key: String, default = null):
	return adb.get_value(section, key, default)

func adb_set(section: String, key: String, value):
	adb.set_value(section, key, value)
