class_name Stats
extends Node
tool
# This is a tool, for the purpose of constantly updating the base
# stat dictionary to its correct _stats_type. It is currently updated both
# whenever the node is instanciated & the stats_type is changed thru inspector

export(ALStats.TYPES) var _stats_type : int = 0 setget _set_stats_type
# Determines stats node's type (dependant on its own parent's - 
# characters, bullets, obstacles, etc)

var setup : Dictionary = ALStats.STATS.duplicate(true)
# Stores up the editor-interface dictionary that defines the in-game
# base dir, based on a complex get_property_list extension (that allows for LOTS
# of extra features and QOLs while setting it up)

var base : Dictionary # base (base) interchangeable stats
# base stats dictionary (exportable for change in between different
# unit scenes, enemies' & so on) - this dictionary is read-only;

func _get_property_list() -> Array:
	var ret: Array = []
	
	for _stat in ALStats.STATS[_stats_type].keys():
		var _type : int = typeof(ALStats.STATS[_stats_type][_stat])
		var _st_name : String = ALStats.STAT.keys()[_stat]
		
		if _st_name.to_upper() in ALStats:
			var _dict = ALStats.get(_st_name.to_upper())
			ret.append({
				"name": ALStats.TYPES.keys()[_stats_type] + "/" +_st_name,
				"type": _type,
				"hint": PROPERTY_HINT_ENUM,
				"hint_string": PoolStringArray(_dict.keys()).join(","),
				"usage": PROPERTY_USAGE_DEFAULT,
			})
		
		else:
			ret.append({
				"name": ALStats.TYPES.keys()[_stats_type] + "/" + _st_name,
				"type": _type,
				"hint": _type,
				"usage": PROPERTY_USAGE_DEFAULT
			})

	return ret

func _set(prop_name: String, val) -> bool:
	if prop_name.begins_with(_get_type_name() + "/"):
		var _split_prop_name : PoolStringArray = prop_name.split("/")
		var _st_type = ALStats.TYPES[_split_prop_name[0]]
		var _new_prop : String = _split_prop_name[1]
		
		var _st_index : int = ALStats.STAT[_new_prop]
		setup[_st_type][_st_index] = val
		property_list_changed_notify()
		return true
	return false

func _get(prop_name: String):
	if prop_name.begins_with(_get_type_name() + "/"):
		property_list_changed_notify()
		
		var _split_prop_name : PoolStringArray = prop_name.split("/")
		var _st_type = ALStats.TYPES[_split_prop_name[0]]
		var _new_prop : String = _split_prop_name[1]
		
		var _st_index : int = ALStats.STAT[_new_prop]
		if setup[_st_type].has(_st_index):
			return setup[_st_type][_st_index]

func _ready() -> void:
	if !Engine.is_editor_hint():
		base = setup[_stats_type].duplicate(true)
		
func _set_stats_type(_value) -> void:
	_stats_type = _value
	if Engine.is_editor_hint():
		setup = ALStats.STATS.duplicate(true)
		property_list_changed_notify()
		# Updates exportable dictionary whenever the stats node type
		# is changed (removes unnecessary type nests & trims it to the
		# correct one; all while in editor, for greater usability)
		
func _get_type_name() -> String:
	return ALStats.TYPES.keys()[_stats_type]
