class_name Pattern
extends Resource

@export var points: PackedVector2Array
@export var last_point: int = -1 # -1 -> no end

func _init(p_points = PackedVector2Array(), p_last_point = -1):
	points = p_points
	last_point = p_last_point
