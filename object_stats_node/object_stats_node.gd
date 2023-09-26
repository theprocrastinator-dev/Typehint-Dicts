@tool
extends Node
class_name ObjectStatsNode
# This is just a container for the object_stats resource. Meant to be parented by game objects like
# the player, creatures, and so on.

@export var _object_stats : ObjectStats = preload("res://stats/object_stats/object_stats.tres")

var current : Dictionary : set = _set_current, get = _get_current
var base : Dictionary : get = _get_base
@warning_ignore("unused_private_class_variable")
var stats_type : AutoloadStats.TYPES : get = _get_stats_type
# Alias get and set methods for easier access.

func _set_current(_value) -> void:
	_object_stats.current = _value

func _get_current():
	return _object_stats.current

func _get_base():
	return _object_stats.base

func _get_stats_type() -> AutoloadStats.TYPES:
	return _object_stats.stats_type

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	_object_stats.initiate()

func _notification(what):
	if what == NOTIFICATION_SCENE_INSTANTIATED:
		_make_stats_unique()

func _make_stats_unique() -> void:
	if Engine.is_editor_hint():
		_object_stats = _object_stats.duplicate(true)
		# Auto duplicates the object_stats whenever this node is instanciated (in-editor)
		# to a new scene, so you don't have to click "make unique" every single time you do it.
