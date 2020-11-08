extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	position = Vector2(1400,300)
	linear_velocity = Vector2(-400,0)
# Called when the node enters the scene tree for the first time.
#func _process(delta):
#	move_and_slide(Vector2(-400,0))

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
