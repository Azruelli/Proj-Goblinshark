extends CameraState
class_name CameraLocked

const focus_following_weight = 44.0
var focus_point := 0.0
var targeted_entity = Node3D
var targets = get_tree().get_nodes_in_group("targetable")
var nearest_target = targets[0]
var set_target = 0.0 
@onready var targetable_node: Targetable = $TargetableNode


func enter() -> void:
	if get_tree().get_nodes_in_group("targetable") and camera.is_position_in_frustum("targetable"):
		var set_target = nearest_target.global_position.distance_to(camera.global_positon)
		#get_parent().get_parent().get_parent().rotate_y(set_target.global_position.x)
		#get_parent().get_parent().rotate_x(set_target.global_position.y)
	#else:
		#Transitioned.emit("CameraUnlocked")
		#camera_lock = 0 

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("LockOn"):
		Transitioned.emit("CameraUnlocked")
		camera_lock = 0

func physics_update(_delta: float) -> void:
	#follow_set_target()
	get_parent().get_parent().get_parent().look_at(set_target.global_position.x)
	get_parent().get_parent().look_at(set_target.global_position.y)

#func follow_set_target() -> void:
	#if get_tree().get_nodes_in_group("targetable") and camera.is_position_in_frustum("targetable"):
		#var set_target = nearest_target.global_position.distance_to(camera.global_positon)
		#get_parent().get_parent().get_parent().rotate_y(set_target.x)
		#get_parent().get_parent().rotate_x(set_target.y)
