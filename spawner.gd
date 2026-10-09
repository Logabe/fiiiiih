extends Path2D

const OFFSET_RANGE = 500
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var prefab = preload("res://constellation/npc fish.tscn")
	var mult = 1
	if randf() > 0.5: mult = -1
	for i in 10:
		var node = prefab.instantiate()
		node.speed *= mult
		node.get_child(0).position.y = randf_range(-OFFSET_RANGE, OFFSET_RANGE)
		add_child(node)
		node.progress_ratio = randf()
