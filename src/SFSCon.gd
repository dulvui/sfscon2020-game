extends Node2D

const Box = preload("res://src/actors/box/Box.tscn")

var score = 0
var high_score = 0

var config

var game_started = false

var tux

func _ready():
	$ColorRect.show()
	
	tux = $Tux
	
	config = ConfigFile.new()
	config.load("user://settings.cfg")
	high_score = config.get_value("data","high_score",0)
	
	$HUD/HighScore.text = "HI " + str(high_score)
	
	$AnimationPlayer.play("FadeIn")
	
func new_high_score():
	high_score = score
	$HUD/HighScore.text = "HI " + str(high_score)
	config.set_value("data","high_score",score)
	config.save("user://settings.cfg")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_started:
		if tux.is_jumping and tux.jump_height > 10:
			$Tux.jump()
			
		$ParallaxBackground/ParallaxLayer.motion_offset += Vector2(-2,0)

func start_game():
	game_started = true
	$HUD/Instructions.hide()
	$Tux/AnimatedSprite.play("walk")
	$Timer.start()

func _input(event):
	if event.is_action_pressed("jump"):
		if not game_started:
			start_game()
		elif tux.on_floor:
			tux.is_jumping = true
	elif event.is_action_released("jump"):
		tux.is_jumping = false

func _on_Timer_timeout():
	var box = Box.instance()
	$BoxSpawner.add_child(box)
	$Timer.wait_time = (randi() % 5) + 1
	$Timer.start()


func _on_PointDetector_body_entered(body):
	score += 1
	$HUD/Score.text = str(score)


func _on_Tux_game_over():
	if score > high_score:
		new_high_score()
	$AnimationPlayer.play("FadeOut")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://src/SFSCon.tscn")
