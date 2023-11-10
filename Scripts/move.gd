extends CharacterBody2D

@export var speed = 1;
@export var y_pos = 0;
var direction = Enums.Directions.UP;

@onready var _animated_sprite = $AnimatedSprite2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == Enums.Directions.UP:
		_animated_sprite.play("");

"""
In order to correctly display animation, animation must titled as follows:
	-Movement animation must be titled "run_<direction>".
	-IDLE animation must be titled "stand_<direction>".
Note: <direction> is the direction the character is facing.
"""
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# true if player moves, else false
	var move: bool = false;
	
	# plays animation corresponding to given action
	for action in Enums.Directions.values():
		var action_name: String = Enums.directionToString(action);
		var animation_name: String = "run_" + action_name;
		if !move and Input.is_action_pressed(action_name):
			_animated_sprite.play(animation_name);
			move = true;
			direction = action
			
	# if player isn't moving, do idle animation
	if !move:
		var idle_animation_name: String = "stand_" + Enums.directionToString(direction);
		_animated_sprite.play(idle_animation_name);
		

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down");
	velocity = input_direction * speed;

func _physics_process(delta):
	get_input();
	# change x pos
	self.position.x += velocity.x;
	# change logical y pos (not graphical y pos)
	y_pos -= velocity.y;
	
	# change scale based off logical y pos
	var scale_factor: float = pow(2, -(y_pos / 100));
	var scaler: Vector2 = Vector2(scale_factor, scale_factor);
	self.scale = scaler;
	
	# change graphical y pos based of logical y pos
	var graph_y_pos: float = 2;
	self.position.y = scale_factor * 100;
