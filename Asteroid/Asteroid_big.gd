extends KinematicBody2D

var velocity = Vector2.ZERO
var small_speed = 3.0
var initial_speed = 3.0
var health = 5

onready var Asteroid = load("res://Asteroid/Asteroid.tscn")
var asteroids = [Vector2(0,-30),Vector2(30,30),Vector2(-30,30)]

func _ready():
	velocity = Vector2(0,initial_speed*randf()).rotated(PI*2*randf())

func _physics_process(_delta):
	position = position + velocity


func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(250)
		collision_layer = 0
		var Asteroid_Container = get_node_or_null("/root/Game/Asteroid_Container")
		if Asteroid_Container != null:
			for s in asteroids:
				var asteroid = Asteroid.instance()
				var dir = randf()*2*PI
				var i = Vector2(0,randf()*small_speed).rotated(dir)
				Asteroid_Container.call_deferred("add_child", asteroid)
				asteroid.position = position + s.rotated(dir)
				asteroid.velocity = i
		queue_free()
