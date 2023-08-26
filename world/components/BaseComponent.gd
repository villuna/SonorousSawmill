class_name BaseComponent extends Node2D

var connectedAxis: int = 0

func connect_direction(direction:int, pos: Vector2i):
	connectedAxis |= 1<<direction
	_render_connections()
	
func disconnect_direction(direction:int, pos: Vector2i):
	connectedAxis &= ~(1<<direction)
	_render_connections()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _render_connections():
	pass
