@tool
extends Resource
class_name Stats
# Stats base class and resource, can be extended both for object_stats (stats for characters, weapons, etc)
# or for resource-based item stats, such as upgrades. Intended to be used by literally everything that
# holds stats.

## Type of the parent's object stats.
@export var stats_type : AutoloadStats.TYPES : set = _set_stats_type
# Determines stats node's type (dependant on its own parent's - 
# characters, bullets, obstacles, etc)

var setup : Dictionary = AutoloadStats.TREE.duplicate(true)
# Stores up the editor-interface dictionary that defines the in-game
# base dir, based on a complex get_property_list extension (that allows for LOTS
# of extra features and QOLs while setting it up)

func _get_property_list() -> Array:
	var ret: Array = []
	
	for _stat in AutoloadStats.TREE[stats_type].keys():
		var _type : int = typeof(AutoloadStats.TREE[stats_type][_stat])
		var _st_name : String = AutoloadStats.STAT.keys()[_stat]
		
		var _dropdown_dict : String = _st_name.to_upper()
		
		if _dropdown_dict in AutoloadStats:
			var _dict = AutoloadStats.get(_dropdown_dict)
			var _packed_keys : PackedStringArray = PackedStringArray(_dict.keys())
			var _joint_keys : String = ",".join(_packed_keys)
			# DEV NOTE: check if it works this way!!!!!!!
			ret.append({
				"name": AutoloadStats.TYPES.keys()[stats_type] + "/" +_st_name,
				"type": _type,
				"hint": PROPERTY_HINT_ENUM,
				"hint_string": _joint_keys,
				"usage": PROPERTY_USAGE_DEFAULT,
			})
		
		else:
			ret.append({
				"name": AutoloadStats.TYPES.keys()[stats_type] + "/" + _st_name,
				"type": _type,
				"hint": PROPERTY_HINT_NONE,
				"usage": PROPERTY_USAGE_DEFAULT
			})
			
	if Engine.is_editor_hint():
		ret.sort_custom(Callable(ArraySorter, "sort_stats"))
# This function alters there way in which properties are displayed in-editor, allowing
# for type-hinted dictionaries with exports! AKA you can use it to set values through 
# enum-dropdown-lists and other more user-friendly methods, in order to make balancing and
# tweaking a much smoother experience.
	return ret

func _set(prop_name: StringName, val) -> bool:
	if prop_name.begins_with(_get_type_name() + "/"):
		var _split_prop_name : PackedStringArray = prop_name.split("/")
		var _st_type = AutoloadStats.TYPES[_split_prop_name[0]]
		var _new_prop : String = _split_prop_name[1]
		
		var _st_index : int = AutoloadStats.STAT[_new_prop]
		setup[_st_type][_st_index] = val
		notify_property_list_changed()
		return true
# Compliments the _get_property_list(). Just standard procedure
	return false

func _get(prop_name: StringName):
	if prop_name.begins_with(_get_type_name() + "/"):
		var _split_prop_name : PackedStringArray = prop_name.split("/")
		var _st_type = AutoloadStats.TYPES[_split_prop_name[0]]
		var _new_prop : String = _split_prop_name[1]
		
		var _st_index : int = AutoloadStats.STAT[_new_prop]
		if setup[_st_type].has(_st_index):
			return setup[_st_type][_st_index]
# Same as with _set()

func _set_stats_type(_value : AutoloadStats.TYPES) -> void:
	notify_property_list_changed()
	
	if stats_type == _value:
		return
		
	stats_type = _value
	
	if not Engine.is_editor_hint() or setup.keys() == AutoloadStats.TREE[stats_type].keys():
		return

	setup = AutoloadStats.TREE.duplicate(true)
	notify_property_list_changed()
	# Updates exportable dictionary whenever the stats node type
	# is changed (removes unnecessary type nests & trims it to the
	# correct one; all while in editor, for greater usability)
	
func _get_type_name() -> String:
	return AutoloadStats.TYPES.keys()[stats_type]
