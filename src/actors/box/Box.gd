extends RigidBody2D


func _ready():
	position = Vector2(1400,300)
	linear_velocity = Vector2(-400,0)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
