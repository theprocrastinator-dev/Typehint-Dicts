extends Node
# This autoload contains commonly referenced & used methods and global values that are
# related any form to STATS (from the Stats node). May their purpose either be related to
# damage calculations, stat categorization & auto-complete const dicts...

enum TYPES {
	CHARACTER,
	VEHICLE,
	WEAPON
}
# Different types of stats (eg.: Creature's vs. Character's)

# LIST OF PRE-DEFINED STAT VALUES ---->

enum RELOAD_MODE {
	FULL,
	INDIVIDUAL
}

# <----

# STAT CONSTS ----->


# <----

enum STAT {
	ACCELERATION,
	MOVE_SPEED,
	HEALTH,
	PICKUP_MAGNETIC,
	RANGE,
	DAMAGE,
	RELOAD_MODE,
	DECELERATION,
	STEERING_SPEED,
	TURNING_TIME,
	HYDRODYNAMICS,
	AIMING_SPEED,
	BACKWARDS_SPEED_FACTOR
}
# Enum of all stat names (so you always get a autocomplete hints whenever
# calling/setting a stat; this way there are no typos nor inconsistencies anywhere!)

const TREE = {
	TYPES.CHARACTER: {
		STAT.ACCELERATION: Vector2.ZERO,
		STAT.MOVE_SPEED: Vector2.ZERO,
		STAT.HEALTH: 0.0,
		STAT.PICKUP_MAGNETIC: 0.0,
		STAT.DECELERATION: Vector2.ZERO,
		STAT.STEERING_SPEED: 0.0,
		STAT.HYDRODYNAMICS: Vector2.ZERO,
		STAT.AIMING_SPEED: 0.0
		},
		
	TYPES.VEHICLE: {
		STAT.ACCELERATION: Vector2.ZERO,
		STAT.MOVE_SPEED: Vector2.ZERO,
		STAT.HEALTH: 0.0,
		STAT.DECELERATION: Vector2.ZERO,
		STAT.STEERING_SPEED: 0.0,
		STAT.TURNING_TIME: 0.0,
		STAT.HYDRODYNAMICS: Vector2.ZERO,
		STAT.AIMING_SPEED: 0.0,
		STAT.BACKWARDS_SPEED_FACTOR: 0.0
		},
	TYPES.WEAPON: {
		STAT.DAMAGE: 0.0,
		STAT.RANGE: 0.0,
		STAT.RELOAD_MODE: RELOAD_MODE.FULL,
		STAT.AIMING_SPEED: 0.0
	}
}
# Constant dictionary that properly attributes stats to each game object
