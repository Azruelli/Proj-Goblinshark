extends CameraState
class_name CameraUnlocked

@onready var camera_mount: Node3D = $CameraMount

var mouse_motion := Vector2.ZERO

func enter() -> void: 
	Input.mouse_mode =Input.MOUSE_MODE_CAPTURED

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("LockOn") and camera_lock == 0:
		Transitioned.emit("CameraLocked")
		camera_lock = 1
		print(camera_lock)

func physics_update(_delta: float) -> void:
	handle_camera_rotation()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			mouse_motion = -event.relative * 0.001
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("Shoot"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func handle_camera_rotation() -> void:
	#THIS IMPLEMENTATION IS DUMB AS FUCK BUT IT WORKS FOR NOW.
	get_parent().get_parent().get_parent().rotate_y(mouse_motion.x)
	get_parent().get_parent().rotate_x(mouse_motion.y)
	get_parent().get_parent().rotation_degrees.x = clampf(
		get_parent().get_parent().rotation_degrees.x, -90.0, 90.0
	)
	mouse_motion = Vector2.ZERO
