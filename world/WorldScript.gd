extends Node

var tileWorld = {}

func getTile(pos: Vector2i): 
	return tileWorld.get(pos, null)

func setTile(pos: Vector2i, instance: Node):
	var existing = tileWorld.get(pos, null)
	if (existing != null):
		$Tiles.remove_child(existing)
		tileWorld.erase(pos)
	if (instance != null):
		var newInstanceClone = instance.duplicate()
		newInstanceClone.name = "WORLD_TILE_OBJECT_"+str(pos.x)+"_"+str(pos.y)
		newInstanceClone.position = pos*128
		newInstanceClone.visible = true
		tileWorld[pos] = newInstanceClone;
		$Tiles.add_child(newInstanceClone)
		return newInstanceClone
	return null
	
func getOrAdd(pos: Vector2i, getType: Callable):
	var existing = tileWorld.get(pos, null)
	if (existing == null):
		var newInstanceClone = getType.call().duplicate()
		newInstanceClone.name = "WORLD_TILE_OBJECT_"+str(pos.x)+"_"+str(pos.y)
		newInstanceClone.position = pos*128
		newInstanceClone.visible = true
		tileWorld[pos] = newInstanceClone;
		$Tiles.add_child(newInstanceClone)
		return newInstanceClone
	return existing
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
