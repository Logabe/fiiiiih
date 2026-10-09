extends PathFollow2D

@export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if speed < 0:
		$Area2D/CollisionShape2D/Sprite2D.flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += (delta*speed)
