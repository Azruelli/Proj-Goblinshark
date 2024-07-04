extends State
class_name CameraState

@export var camera: Node3D
#var possible_targets = {}

var camera_lock = 0

func _ready() -> void:
	pass

func LockCamera() -> void:
	if Input.is_action_just_pressed("LockOn") and camera_lock == 0:
		Transitioned.emit("CameraLocked")
		print(camera_lock)

func UnlockCamera() -> void:
	if Input.is_action_just_pressed("LockOn") and camera_lock == 1:
		Transitioned.emit("CameraUnlocked")
		print(camera_lock)

func find_target() -> Node3D:
	var possible_targets = get_tree().get_nodes_in_group("targetable")
	for possible_target in possible_targets:
		if not camera.is_position_in_frustum(possible_target.global_position):
			possible_targets.erase(possible_target)
		if camera.root_player.camera_focus.global_position.distance_squared_to(possible_target):
			possible_targets.erase(possible_target)
	if not possible_targets.is_empty():
		return possible_targets[0]
	return null
