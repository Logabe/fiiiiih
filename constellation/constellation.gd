extends Node2D

@export var delay = .5
@onready var reel = $Reel

var points = [] # All the points, in the order the player must link them
var added_counter = 0
var connected_counter = 0

var center = Vector2(1152, 648) / 2

func _ready() -> void:
	for i in 5:
		points.append(Vector2(randf_range(-300, 300), randf_range(-300, 300)) + center)
	
	var tween = create_tween()
	for point in points:
		tween.tween_callback(add_point)
		tween.tween_interval(delay)

func add_point():
	var star: Area2D = preload("res://constellation/star.tscn").instantiate()
	star.position = points[added_counter]
	star.mouse_entered.connect(_mouse_entered.bind(star))
	add_child(star)
	added_counter += 1

func _mouse_entered(node: Area2D):
	if node.position == points[connected_counter]:
		reel.add_point(node.position)
		connected_counter += 1;
	else:
		get_tree().quit() # crash for now
