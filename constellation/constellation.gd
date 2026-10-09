extends Control
# hi this is logan. this code ugly af

@export var delay = .6
@onready var reel = $Reel
@export var patterns: Dictionary[String, Pattern]

var points = [] # All the points, in the order the player must link them
var stars = []
var added_counter = 0
var connected_counter = 0

var center = Vector2(1152, 648) / 2
var can_draw = false

func _ready() -> void:
	var pattern = patterns["delphinus"]
	points = pattern.points
	#for i in 5:
		#points.append(Vector2(randf_range(-300, 300), randf_range(-300, 300)) + center)
	
	var tween = create_tween()
	for point in points:
		tween.tween_callback(add_point)
		tween.tween_interval(delay)
	
	if pattern.last_point != -1:
		tween.tween_callback(twinkle.bind(pattern.last_point))
		points.append(points[pattern.last_point])
	reel.add_point(get_global_mouse_position())
	await tween.finished
	can_draw = true

func _process(delta: float) -> void:
	if can_draw:
		_set_end_pos(get_global_mouse_position())

func add_point():
	var star: Area2D = preload("res://constellation/star.tscn").instantiate()
	star.position = points[added_counter]
	star.mouse_entered.connect(_mouse_entered.bind(star))
	add_child(star)
	stars.append(star)
	added_counter += 1

func _mouse_entered(node: Area2D):
	if !can_draw:
		return
	
	var index = points.find(node.position, connected_counter)
	if index == connected_counter:
		_set_end_pos(node.position)

		reel.add_point(node.position)
		connected_counter += 1
		
		if connected_counter >= len(points):
			can_draw = false
	elif connected_counter == -1:
		reel.default_color = Color.RED
		can_draw = false
		_set_end_pos(node.position)

func twinkle(last_point: int):
	var tween = create_tween()
	var node = stars[last_point]

	tween.tween_property(node , "scale", Vector2(1.5, 1.5), 0.3)
	tween.tween_property(node , "scale", Vector2(1, 1), 0.3)
	
func _set_end_pos(pos: Vector2):
	reel.set_point_position(reel.get_point_count()-1, pos)
