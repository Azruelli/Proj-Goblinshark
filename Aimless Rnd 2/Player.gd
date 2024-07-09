extends CharacterBody3D

class_name Player

var player_health_maximum = 100
var player_health = player_health_maximum


#var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
#var player_is_on_floor = is_on_floor()

#Ground 
const SPEED = 6.0

#Jump
const JUMP_VELOCITY = 6.5

#Air Values
const AIR_FRICTION = .996
const AIR_SPEED = 8.0 

var AIRTIME_MAXIMUM = 1
var AIRTIME = AIRTIME_MAXIMUM

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(_delta: float) -> void:
	move_and_slide()
	if player_health <= 0:
		die()
	if is_on_floor() and Input.is_action_just_pressed("Jump"):
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("reloadscene"):
		reload()

func die() -> void:
	get_tree().quit()

func reload() -> void:
	get_tree().reload_current_scene()
