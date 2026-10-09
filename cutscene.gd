extends Node2D
@export var slide: TextureRect
var num = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		num += 1
	
	if num == 1:
		slide.texture = load("res://assets/cutscene/2.png")
	elif num == 2:
		slide.texture = load("res://assets/cutscene/3.png")
	elif num == 3:
		slide.texture = load("res://assets/cutscene/4.png")
	elif num == 4:
		slide.texture = load("res://assets/cutscene/5.png")
	elif num == 5:
		slide.visible = false
		get_tree().change_scene_to_file("res://game.tscn")
		
			
	
		
