extends Node
const PlayerState := {
		VICTORY = "Victory",
		SMALL = "Small",
		BIG = "Big",
		FIRE = "Fire",
		DEAD = "Dead",
		GROWING = "Growing",
		SHRINKING = "Shrinking",
	}
enum EnemyState {WALKING, DEAD}
enum ItemState {IDLE, WALKING, GENERATING}
enum PiranhaState {PiranhaDefault, PiranhaWalk, PiranhaGetDown, PiranhaGetUp, PiranhaDance}
