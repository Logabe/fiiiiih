extends Node2D
@export var flip: AnimationPlayer
@export var info_card: TextureRect
var fliped = true
var flipedtwo = true
signal done

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		if fliped == true: #flips to constlations
			flip.play("flip")
			info_card.texture = load("res://assets/planet cards/4jupiter.png")
			fliped = false
		elif fliped == false: #flips to lore
			flip.play("large-lore")
			info_card.texture = load("res://assets/planet cards/5mars.png")
			flipedtwo = false
			fliped = null
		elif flipedtwo == false: #makes everything dissapear
			info_card.visible = false
			done.emit()
