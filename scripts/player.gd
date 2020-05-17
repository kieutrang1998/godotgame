extends KinematicBody2D


var motion = Vector2()
export var maxspeed = 150
export var jump = 350
export var g = 10
export(int) var hp = 10
const FIREBALL = preload("res://scenes/fireball.tscn")
const ULTI = preload("res://scenes/ultimate.tscn")
var dev_mod = false
var is_live = true
var is_start = false
var coins = 0
var sfire = 3
var sulti = 0
func _is_live():
	motion.y += g
	if dev_mod == false:
		motion.x = min(motion.x+20, maxspeed)
		$cute.play("run")
		$cute.flip_h = false
		$cute.position = Vector2(0, 1)
	
	if Input.is_action_pressed("on_mod"):
		motion.x = 0
		$cute.play('idle')
		dev_mod = true
	elif Input.is_action_pressed("off_mod"):
		dev_mod = false
	if is_on_floor():
		if Input.is_action_just_pressed("my_up"):
			motion.y = -jump
	else:
		if motion.y < 0:
			$cute.play("jump")
		else:
			$cute.play("fall")
	if Input.is_action_just_pressed("my_attack"):
		skill_q()
	if Input.is_action_just_pressed("my_ulti"):
		skill_r()
	motion = move_and_slide(motion, Vector2(0, -1))
	
	if get_slide_count() > 0:
		for i in range (get_slide_count()):
			if "enemies" in get_slide_collision(i).collider.name:
				_is_dead()

func skill_q():
	if sfire > 0:
		print(sfire)
		var ballposition = sign($Position2D.position.x)
		$Position2D.position = Vector2(30, 0)
		var fileball = FIREBALL.instance()
		fileball.set_direction(ballposition)
		get_parent().add_child(fileball)
		fileball.position = $Position2D.global_position
		set_fire(-1)

func skill_r():
	if sulti > 0:
		var ballposition = sign($Position2D.position.x)
		$Position2D.position = Vector2(30, -10)
		var ulti = ULTI.instance()
		ulti.set_direction(ballposition)
		get_parent().add_child(ulti)
		ulti.position = $Position2D.global_position
		set_ulti(-1)

func _physics_process(delta):
	delta = delta
	if is_start == false:
		motion.y += g
		motion = Vector2(0, 0)
		$cute.play("idle")
	elif is_start == true:
		if is_live == true:
			_is_live()
	
func _is_dead():
	is_live = false
	motion = Vector2(0, 0)
	$cute.play("dead")
	$CollisionShape2D.call_deferred("set_disabled", true)
	$TimerDead.start()
func _on_Timer_timeout():
	maxspeed += 20


func _on_TimerDead_timeout():
	get_tree().change_scene("res://scenes/menu.tscn")

func _on_TimerStart_timeout():
	is_start = true

func set_coin(x):
	coins+=x

func set_fire(x):
	sfire += x
func set_ulti(x):
	sulti += x
func set_hp(n):
	hp += n
