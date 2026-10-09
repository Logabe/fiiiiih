extends CollisionShape2D
var castPoint
var castOrigin
var initialClickPos
var isCastIntersectingFish
var currentFish: Node # the fish that's currently on the line
@onready var line: Line2D = $Line2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	castPoint = get_node("cast origin/cast point")
	castOrigin = get_node("cast origin")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	line.visible = Input.is_action_pressed("left_click")
	
	if Input.is_action_just_pressed("left_click"):
		initialClickPos = get_viewport().get_mouse_position()
		
		print(initialClickPos)
		
	if Input.is_action_pressed("left_click"):
		var whereIsPointerRightNowQuestionMark = get_viewport().get_mouse_position()
		var bobber_pos = castOrigin.position + (initialClickPos + (-1 * whereIsPointerRightNowQuestionMark))
		castPoint.position = bobber_pos
		line.set_point_position(1, bobber_pos)
	
	elif Input.is_action_just_released("left_click"):
		if isCastIntersectingFish == true:
			var scene = preload("res://constellation/constellation.tscn").instantiate()
			get_tree().paused = true
			var id = currentFish.get_parent().id
			if id:
				scene.pattern = scene.patterns[id]
			add_sibling(scene)
			scene.global_position = Vector2.ZERO
			scene.won.connect(_on_game_won if id else close_game)
			scene.lost.connect(close_game)

func _on_cast_point_area_entered(area: Area2D) -> void:
	isCastIntersectingFish = true
	currentFish = area

func _on_cast_point_area_exited(area: Area2D) -> void:
	isCastIntersectingFish = false
	currentFish = null

func _on_game_won():
	var scene = preload("res://pop-up ui.tscn").instantiate()
	add_sibling(scene)
	await scene.done
	scene.queue_free()
	close_game()
	
func close_game():
	get_tree().paused = false
	currentFish.queue_free()
