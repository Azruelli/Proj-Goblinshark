extends CharacterBody3D

class_name Player

#var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
#var player_is_on_floor = is_on_floor()

#Ground 
const SPEED = 5.0

#Jump
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(_delta: float) -> void:
	move_and_slide()

