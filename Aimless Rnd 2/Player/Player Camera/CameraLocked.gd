extends CameraState
class_name CameraLocked

const focus_following_weight = 44.0
var focus_point := 0.0
var targeted_entity = Node3D
#var targets = get_tree().get_nodes_in_group("targetable")
#var nearest_target = targets[0]
var set_target = 0.0 
#@onready var targetable_node: Targetable = $TargetableNode
#@onready var raycast_bullet: RayCast3D = $"CameraMount/Camera3D/Raycast Bullet"
@onready var camera_3d: Camera3D = $"../../Camera3D"
@onready var raycast_lockon: RayCast3D = $"../../Camera3D/RaycastLockon"


func LockOn() -> void:
	if Input.is_action_just_pressed("LockOn"):
		if raycast_lockon.is_colliding():
			var LOCK_TARGET = raycast_lockon.get_collider()
			if LOCK_TARGET.is_in_group("Enemy"):
				print("Found Target")
				#camera_3d.look_at()
	else:
		UnlockCamera()
		return

func enter() -> void:
	pass
	#if get_tree().get_nodes_in_group("targetable") and camera.is_position_in_frustum("targetable"):
		#var set_target = nearest_target.global_position.distance_to(camera.global_positon)
		#get_parent().get_parent().get_parent().rotate_y(set_target.global_position.x)
		#get_parent().get_parent().rotate_x(set_target.global_position.y)
	#else:
		#Transitioned.emit("CameraUnlocked")
		#camera_lock = 0 

func exit() -> void:
	pass

func update(_delta: float) -> void:
	UnlockCamera()

func physics_update(_delta: float) -> void:
	LockOn()
	#follow_set_target()
	#get_parent().get_parent().get_parent().look_at(set_target.global_position.x)
	#get_parent().get_parent().look_at(set_target.global_position.y)

#func follow_set_target() -> void:
	#if get_tree().get_nodes_in_group("targetable") and camera.is_position_in_frustum("targetable"):
		#var set_target = nearest_target.global_position.distance_to(camera.global_positon)
		#get_parent().get_parent().get_parent().rotate_y(set_target.x)
		#get_parent().get_parent().rotate_x(set_target.y)
