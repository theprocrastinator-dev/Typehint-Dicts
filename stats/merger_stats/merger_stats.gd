@tool
extends Stats
class_name MergerStats
# This stats module is intended to be used for upgrades and buffs/debuffs;
# Will ADD to the target object all stats (in-editor) that are different than 0.
# Then, if it is to be deactivated for any reason, it'll subtract them back.

func merge(_owner_stats : Stats, _stats_source : Dictionary, _toggle : bool, _source_type : AutoloadStats.TYPES) -> void:
	var _source_type_name : String = _owner_stats._get_type_name()
	# Retrieves stats type from source (Weapon, Character, etc.).
	var _stats_target : Dictionary = setup[_source_type]
	# Alias for merger's base stats.
	for _key in _stats_target.keys():
		var _type_check : bool = typeof(_stats_target[_key]) == TYPE_FLOAT or TYPE_INT
		# Can only add to either ints or floats, after all
		if not _stats_source.has(_key) or _stats_target[_key] == 0 or not _type_check:
			continue
			
		var _toggle_mp : int = int(_toggle) * 2 - 1
		_stats_source[_key] += _stats_target[_key] * _toggle_mp
		# Adds/subtracts merger stats from source depending on the toggle.
