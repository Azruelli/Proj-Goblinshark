class_name walking
extends Player



# Called when the node enters the scene tree for the first time.
func enter() -> void:
	print("walking")

func update(float) -> void:
	pass


func exit() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta: float) -> void:
	if is_on_floor():
		AIRTIME = AIRTIME_MAXIMUM


func walking_phys() -> void: 
	pass


func tap_time_dash() -> void:
	if is_on_floor():
		AIRTIME = AIRTIME_MAXIMUM
	#else:
		#tap_time = tap_time - 1





func _on_walking_state_physics_processing(delta: float) -> void:
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = lerp(velocity.x, direction.x * SPEED, SPEED * deltaSuper * .5)
			velocity.z = lerp(velocity.z, direction.z * SPEED, SPEED * deltaSuper * .5)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED * deltaSuper)
			velocity.z = move_toward(velocity.z, 0, SPEED * deltaSuper)
			#tap_time = tap_time - 1
