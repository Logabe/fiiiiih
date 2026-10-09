extends Control
# hi this is logan. this code ugly af

@export var delay = .7
@onready var reel = $Reel
@export var patterns: Dictionary[String, Pattern]

signal won
signal lost

var points = [] # All the points, in the order the player must link them
var stars = []
var added_counter = 0
var connected_counter = 0

var can_draw = false
var center = Vector2(1152, 648) / 2
var pattern: Pattern

var nth = 0

func _ready() -> void:
	if pattern:
		points = pattern.points.duplicate()
	else:
		for i in 3 + int(sqrt(Globals.fish_caught)):
			points.append(Vector2(randf_range(-300, 300), randf_range(-300, 300)) + center)
	
	show_stars()

func show_stars():
	added_counter = 0
	can_draw=false
	var tween = create_tween()
	for point in points:
		tween.tween_callback(add_point)
		tween.tween_interval(delay)
	
	reel.add_point(get_global_mouse_position())
	await tween.finished
	can_draw = true

func _process(delta: float) -> void:
	if can_draw:
		$GPUParticles2D.position = get_global_mouse_position() + Vector2(randf_range(-10, 10), randf_range(-10, 10))
		_set_end_pos(get_global_mouse_position())

func add_point():
	var pos = points[added_counter]
	var query = get_children().find_custom(func(x): return x.position.distance_squared_to(pos) <25)
	
	var star
	if query != -1:
		star = get_children()[query]
		if star not in stars:
			stars.append(star)
	else:
		star = preload("res://constellation/star.tscn").instantiate()
		star.position = pos
		star.mouse_entered.connect(_mouse_entered.bind(star))
		add_child(star)
	stars.append(star)
	added_counter += 1
	
	var tween = create_tween()
	tween.tween_property(star, "scale", Vector2(1.5, 1.5), 0.3)
	tween.tween_property(star, "scale", Vector2(1, 1), 0.3)
	

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
			var tween = create_tween()
			tween.tween_property(reel, "default_color", Color.GOLD, 1)
			if nth == 0 and pattern.second_line:
				points = pattern.second_line.duplicate()
				nth = 1
				connected_counter = 0
				reel = Line2D.new()
				reel.width = 2
				stars = []
				add_child(reel)
				show_stars()
			else:
				tween.tween_interval(0.5)
				tween.tween_callback(won.emit)
				tween.tween_callback(queue_free)
				Globals.fish_caught += 1
			
	elif node != stars[connected_counter-1]:
		reel.default_color = Color.RED
		can_draw = false
		
		_set_end_pos(node.position)
		var tween = create_tween()
		tween.tween_interval(1)
		tween.tween_callback(lost.emit)
		tween.tween_callback(queue_free)
	
func _set_end_pos(pos: Vector2):
	reel.set_point_position(reel.get_point_count()-1, pos)
