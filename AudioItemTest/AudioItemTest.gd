extends Node2D

var selected
@onready var generator = $Generator
@onready var speaker = $Speaker

func _create_sound():
	var item = generator.CreateAudioItem()
	item.set_position(Vector2(300, 300))
	item.Clicked.connect(_set_selected)
	add_child(item)

func _play_sound():
	if selected != null:
		var buffer = selected.GetBuffer()
		print(buffer.size())

		speaker.PlaySound(selected.GetBuffer())
		selected.queue_free()
		selected = null

func _set_selected(node):
	selected = node
