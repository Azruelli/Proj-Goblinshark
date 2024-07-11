extends CharacterBody3D

class_name Player

#some basic establishing player values
var player_health_maximum = 100
var player_health = player_health_maximum
var player_speed : Vector3

#var for player direction so downstring scripts can reference it as a normalized vector outside of 
#established items
var direction : Vector3

@onready var player_fsm: StateChart = $PlayerFSM

#const and vars for dashing
const tap_combo_timeout = 0.3
const tap_combo_chain = 2
const tap_time_cooldown_start = 180
var tap_time_cooldown = 0
var tap_time_delta = 0.0
var tap_time_array = []
var tap_time_left = ["Left", "Left"]
var tap_time_right = ["Right", "Right"]
var dashing_flag = false

var deltaSuper: float = Engine.get_main_loop().root.get_process_delta_time()

const GROUND_FRICTION = .996
const SPEED = 8.0

#Jump
const JUMP_VELOCITY = 7.5
const DASH_JUMP_VELOCITY = 3.5

#Air Values
const AIR_FRICTION = .995
const AIR_SPEED = 9.5

var AIRTIME_MAXIMUM = 1
var AIRTIME = AIRTIME_MAXIMUM

#grappling hook stuff stolen from garbaj for test implementation
@onready var grapplehook_ray: RayCast3D = $CameraMount/Camera3D/GrapplehookRay
var latchable = false
var latchpoint: Vector3
var latchpoint_flag = false
var grapple_snaptime = 60
var grapple_snap = 0 
var grapple_time: int
var grapples_maximum = 1
var grapples_left = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	state_input_listen()
	#tap_time_delta += delta

	grapple_latch()

#simple gravity math
	velocity.y -= gravity * delta

	move_and_slide()
	
	if player_health <= 0:
		die()
	if is_on_floor() and Input.is_action_just_pressed("Jump"):
		velocity.y = JUMP_VELOCITY

func die() -> void:
	get_tree().quit()

func state_input_listen() -> void:
	#kind of crappy implementation that is sure to cause conflicts later
	#if tap_time_delta <= tap_combo_timeout and tap_time_cooldown <= 0: 
		#if is_on_floor() and Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"): 
			#print("dashed")
			#player_fsm.send_event("dash")
	if velocity.x == 0 and velocity.y == 0 and velocity.z == 0 and not Input.is_anything_pressed():
		player_fsm.send_event("idle")
	if not is_on_floor():
		player_fsm.send_event("air")
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor() and direction:
		player_fsm.send_event("walking")


func _process(delta: float) -> void:
	reset_scene()
	air_time_reset()
	tap_time_cooldown = tap_time_cooldown - 1

func grapple_latch() -> void:
	if Input.is_action_just_pressed("grapple") and grapplehook_ray.is_colliding() and grapples_left > 0:
		grapples_left = grapples_left - 1
		if not latchable:
			latchable = true
	if latchable:
		velocity.y = 0
		if not latchpoint_flag:
			latchpoint = grapplehook_ray.get_collision_point() + Vector3(1, 1, 1)
			latchpoint_flag = true
		if latchpoint.distance_to(transform.origin) > 2:
			grapple_time = grapple_time - 1
			print(grapple_time)
			if grapple_time == grapple_snap:
				latchpoint_flag = false
				latchable = false
			if latchpoint_flag:
				transform.origin = lerp(transform.origin, latchpoint, .08)
		else:
			latchpoint_flag = false
			latchable = false
	else:
		latchpoint_flag = false
		latchable = false


func air_time_reset() -> void:
	if is_on_floor():
		AIRTIME = AIRTIME_MAXIMUM

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_released("Left") or event.is_action_released("Right"):
			tap_time_delta = 0.0

#func tap_time_remastered(event: InputEvent) -> void:
	#if event is InputEventKey and event.is_pressed() and event.is_echo():
		#print(tap_time_delta)
		#if tap_time_delta > .3:
			#tap_time_array = []
		#tap_time_array.append(event.scancode)
		#if tap_time_array.size() > tap_combo_chain:
			#tap_time_array.pop_front()

func _on_walking_state_entered() -> void:
	grapple_time = grapple_snaptime
	grapples_left = grapples_maximum


func _on_walking_state_physics_processing(delta: float) -> void:
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor(): 
		if direction:
			dashing_flag = false
			velocity.x = lerp(velocity.x, direction.x * SPEED, SPEED * delta * .7)
			velocity.z = lerp(velocity.z, direction.z * SPEED, SPEED * delta * .7)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED * delta * GROUND_FRICTION)
			velocity.z = move_toward(velocity.z, 0, SPEED * delta * GROUND_FRICTION)

func _on_air_state_entered() -> void:
	pass


func _on_air_state_physics_processing(delta: float) -> void:
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() 
	if direction and Input.is_action_just_pressed("dash") and dashing_flag == false:
		velocity.x = direction.x * AIR_SPEED *  4
		velocity.z = direction.z * AIR_SPEED *  4
		velocity.y = .3
		dashing_flag = true
	if direction:
		velocity.x = lerp(velocity.x, direction.x * AIR_SPEED, AIR_SPEED * delta * .5)
		velocity.z = lerp(velocity.z, direction.z * AIR_SPEED, AIR_SPEED * delta * .5)
		AIRTIME = AIRTIME * AIR_FRICTION
		
	else:
		velocity.x = move_toward(direction.x * (AIRTIME * AIR_SPEED), 0, SPEED * delta * 0.5)
		velocity.z = move_toward(direction.z * (AIRTIME * AIR_SPEED), 0, SPEED * delta * 0.5)


#func _on_dashing_state_physics_processing(delta: float) -> void:
	#var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() 
	#if direction:
		#velocity.x = direction.x * 10
		#velocity.z = direction.z * 10


func reset_scene() -> void: 
	if Input.is_action_just_pressed("ui_end"):
		get_tree().reload_current_scene()


#func _on_dashing_state_entered() -> void:
		#velocity.x = direction.x * SPEED * 400
		#velocity.z = direction.z * SPEED * 400
		#velocity.y = DASH_JUMP_VELOCITY
		#tap_time_cooldown = tap_time_cooldown_start


