extends Node2D

const Box = preload("res://Box.tscn")

var score = 0

var jump_power = 900

var is_jumping = false

var on_floor = true

var game_started = false

# Called when the node enters the scene tree for the first time.
func _ready():
#	$Timer.start()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_started:
		if is_jumping and jump_power > 10:
			jump_power *= 0.9
			jump()
		elif on_floor:
			jump_power = 900
			
		$ParallaxBackground/ParallaxLayer.motion_offset += Vector2(-2,0)

func start_game():
	game_started = true
	$Instructions.hide()
	$Tux/AnimatedSprite.play("walk")
	$Timer.start()

func _input(event):
	if event.is_action_pressed("jump"):
		if not game_started:
			start_game()
		elif on_floor:
			is_jumping = true
	elif event.is_action_released("jump"):
		is_jumping = false


func jump():
	$Tux.set_axis_velocity(Vector2(0,-jump_power))
	

func _on_FloorDetector_body_entered(body):
	if game_started:
		if body.is_in_group("box"):
			get_tree().change_scene("res://SFSCon.tscn")
		else:
			on_floor = true
			is_jumping = false
			$Tux/AnimatedSprite.play("walk")


func _on_FloorDetector_body_exited(body):
	on_floor = false
	$Tux/AnimatedSprite.play("jump")
	


func _on_Timer_timeout():
	var box = Box.instance()
	add_child(box)
	$Timer.wait_time = (randi() % 5) + 1
	$Timer.start()


func _on_PointDetector_body_entered(body):
	score += 1
	$Score.text = str(score)
