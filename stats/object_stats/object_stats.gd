@tool
extends Stats
class_name ObjectStats
# This stats module is intended to be used along with a object_stats_node, as child of a game object,
# such as a character, create, and so on.

var base : Dictionary
# base stats; permanently increased by upgrades.
var current : Dictionary
# current stats; based on the default stats, but can be changed during gameplay
# (such as by powerups, debuffs and such)

func initiate() -> void:
	base = setup[stats_type].duplicate(true)
	if current.is_empty():
		_reset_stats()
		# For first time setup, clone current from base stats.

func _reset_stats() -> void:
	current = base.duplicate(true)
	# Sets current stats back to their default (base)
