extends MeshInstance3D

@export var damage = 4
@export var fire_time := 0.2
var fire_current: float
@export var load_time := 0.02
@export var max_load := 0.2

@onready var hand: Node3D = $".."
@onready var bullet: RayCast3D = $"../../Raycast Bullet"


func Fire_Gun() -> void:
	if Input.is_action_just_pressed("Shoot"):
		if fire_current == fire_time: 
			fire_current == fire_current - fire_time
			print("Fired a shot")
			if bullet.is_colliding():
				var target = bullet.get_collider()
				if target.is_in_group("Enemy"):
					print("shot hit")
					target.health -= damage
	elif fire_current > fire_time:
		fire_current = fire_time
	else:
		if fire_current < 0.2:
			fire_current = fire_current + load_time

signal Shot_fired

func Swap() -> void:
	pass

func update() -> void:
	pass

func _physics_process(delta: float) -> void:
	Fire_Gun()
