extends TextureRect
@export var flip: AnimationPlayer 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("test")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		print("testtest")
		
		
