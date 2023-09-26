class_name ArraySorter

static func sort_stats(a, b):
	var _a_name : String = a["name"].split("/")[1]
	var _b_name : String = b["name"].split("/")[1]
	
	if _a_name[0] < _b_name[0]:
		return true
	return false
