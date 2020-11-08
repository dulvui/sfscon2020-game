extends RigidBody2D

signal game_over

var is_jumping = false

var on_floor = true

var jump_height = 900




func _on_FloorDetector_body_entered(body):
	if get_parent().game_started:
		if body.is_in_group("box"):
			emit_signal("game_over")
		else:
			on_floor = true
			jump_height = 900
			is_jumping = false
			$AnimatedSprite.play("walk")


func jump():
	set_axis_velocity(Vector2(0,-jump_height))
	jump_height *= 0.9
	


func _on_FloorDetector_body_exited(body):
	on_floor = false
	$AnimatedSprite.play("jump")
