extends Node
@onready var W = $"/root/Base/World"
var instance: Node = null
var hold_position: Vector2i = Vector2i(0,0) 

var DIRLUT = {
	Vector2i(1,0) : 0,
	Vector2i(0,-1) : 1,
	Vector2i(-1,0) : 2,
	Vector2i(0,1) : 3
}

func _unhandled_input(event):
	if event is InputEventMouseButton:
		var tilepos = screen2tile(event.position)
		if (event.button_index == MOUSE_BUTTON_WHEEL_DOWN && event.pressed): 
			$"../PrimaryCamera".zoom *= 0.9
		if (event.button_index == MOUSE_BUTTON_WHEEL_UP && event.pressed): 
			$"../PrimaryCamera".zoom *= 1.1111111111
		if (3 <= event.button_index && event.button_index <= 7):
			return 
			
		if (event.button_index == MOUSE_BUTTON_LEFT):
			hold_position = screen2tile(event.position)
			if (W.getTile(hold_position)==null):
				W.setTile(hold_position, instance)
			return
		
		if ((event.button_mask & MOUSE_BUTTON_RIGHT) != 0):
			W.setTile(tilepos, null)
			
	if event is InputEventMouseMotion:
		var tilepos = screen2tile(event.position)	
		if ((event.button_mask & MOUSE_BUTTON_RIGHT) != 0):
			W.setTile(tilepos, null)
		
		if ((event.button_mask&MOUSE_BUTTON_MASK_MIDDLE) != 0):
			$"../PrimaryCamera".position -= event.relative * (Vector2(1,1)/$"../PrimaryCamera".zoom)
		else:
			var highlighter = $"../World/CurrentTileHighlighter"
			highlighter.position =  tilepos * 128
			
			if ((event.button_mask & MOUSE_BUTTON_LEFT) != 0):
				var delta = hold_position-tilepos
				if (tilepos != hold_position):
					var intdir = DIRLUT.get(delta, null)
					if (intdir != null):
						var holdPosObj = W.getOrAdd(hold_position, func(): return instance)
						var newPosObj = W.getOrAdd(tilepos, func(): return instance)
						holdPosObj.connect_direction(intdir, tilepos)
						newPosObj.connect_direction(DIRLUT[-delta], hold_position)
					hold_position = tilepos
			
	
func screen2tile(pos: Vector2):
	#var wpos = $"../PrimaryCamera".to_local(pos * (Vector2(1,1)/$"../PrimaryCamera".zoom)) 
	var wpos = $"../PrimaryCamera".get_canvas_transform().affine_inverse() * pos
	wpos = (wpos/128).floor()
	return Vector2i(wpos)



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
