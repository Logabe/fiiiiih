extends CollisionShape2D
var castPoint
var castOrigin
var initialClickPos
var isCastIntersectingFish
var currentFish # the fish that's currently on the line

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	castPoint = get_node("cast origin/cast point")
	castOrigin = get_node("cast origin")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += (delta*5)
	
	if Input.is_action_just_pressed("left_click"):
		initialClickPos = get_viewport().get_mouse_position()
		
		print(initialClickPos)
		
	if Input.is_action_pressed("left_click"):
		var whereIsPointerRightNowQuestionMark = get_viewport().get_mouse_position()
		castPoint.position = castOrigin.position + (initialClickPos + (-1 * whereIsPointerRightNowQuestionMark))
	
	
	elif Input.is_action_just_released("left_click"):
		if isCastIntersectingFish == true:
			var scene = preload("res://constellation/constellation.tscn").instantiate()
			add_sibling(scene)
			scene.global_position = Vector2.ZERO
			get_tree().paused = true
			scene.won.connect(_on_game_won)
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
	close_game()
	
func close_game():
	get_tree().paused = false
	currentFish.queue_free()
