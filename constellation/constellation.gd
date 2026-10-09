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
	
	reel.add_point(get_global_mouse_position())

func _process(delta: float) -> void:
	_set_end_pos(get_global_mouse_position())

func add_point():
	var star: Area2D = preload("res://constellation/star.tscn").instantiate()
	star.position = points[added_counter]
	star.mouse_entered.connect(_mouse_entered.bind(star))
	add_child(star)
	added_counter += 1

func _mouse_entered(node: Area2D):
	if added_counter != len(points):
		return
	
	var index = points.find(node.position)
	if index == connected_counter:
		_set_end_pos(node.position)

		reel.add_point(node.position)
		connected_counter += 1
		if connected_counter >= len(points):
			queue_free() # uhh u win
	elif index > connected_counter:
		get_tree().quit() # crash for now

func _set_end_pos(pos: Vector2):
	reel.set_point_position(reel.get_point_count()-1, pos)
