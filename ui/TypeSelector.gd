extends ItemList

@export var instances: Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready():
	select(1)
	select(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_item_selected(index):
	get_parent().instance = instances[index]
