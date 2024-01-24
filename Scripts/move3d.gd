"""
This script is able to move the character left, right, down, up.
This script also controls idle and movement animation for the chracter.

In order to correctly display animation, animation must titled as follows:
	-Movement animation must be titled "run_<direction>".
	-IDLE animation must be titled "stand_<direction>".
Note: <direction> is the direction the character is facing.
"""

extends CharacterBody3D

"""arbitrary speed value. larger number means chracter is faster"""
@export var speed = 40;

# the direction that the character is facing
var _direction = Enums.Directions.UP;

@onready var _animated_sprite = $AnimatedSprite3D;

# Initializes chracter animation
func _ready():
	var action_name: String = Enums.directionToString(_direction);
	var animation_name: String = "stand_" + action_name;
	_animated_sprite.play(animation_name);

# Updates player location and the character animation based off
# user input.
func _process(_delta):
	# true if player moves, else false
	var move: bool = false;
	
	# plays animation corresponding to given action
	for action in Enums.Directions.values():
		var action_name: String = Enums.directionToString(action);
		var animation_name: String = "run_" + action_name;
		if !move and Input.is_action_pressed(action_name):
			_animated_sprite.play(animation_name);
			move = true;
			_direction = action;
			
	# if player isn't moving, do idle animation
	if !move:
		var idle_animation_name: String = "stand_" + Enums.directionToString(_direction);
		_animated_sprite.play(idle_animation_name);

# retrieves user input and updates chracter velocity accordingly
func _get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down");
	velocity.x = input_direction.x;
	velocity.z = input_direction.y;
	velocity.y = 0;

# moves player character based off velocity at current time step
func _physics_process(delta):
	_get_input();
	velocity *= delta * speed;
	move_and_slide()
