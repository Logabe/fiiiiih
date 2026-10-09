extends PathFollow2D

@export var speed = 100
var randNum = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if speed < 0:
		$Area2D/CollisionShape2D/Sprite2D.flip_h = true
		
	speed = speed+randNum.randf_range(-10.0, 3.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += (delta*speed)
