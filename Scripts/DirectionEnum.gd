class_name Enums

# enum representing the four directions the player can move
enum Directions {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

# returns the string representation of direction
static func directionToString(direction : Directions) -> String:
	if direction == Directions.UP:
		return "up";
	elif direction == Directions.DOWN:
		return "down";
	elif direction == Directions.LEFT:
		return "left";
	else:
		return "right";
