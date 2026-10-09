class_name Pattern
extends Resource

@export var points: PackedVector2Array
@export var second_line: PackedVector2Array

func _init(p_points = PackedVector2Array(), p_last_point = -1, p_line2 = PackedVector2Array()):
	points = p_points
	second_line = p_line2
