extends CharacterBody2D

@export var speed = 1
@export var y_pos = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
