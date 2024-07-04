extends PlayerState
class_name Air

var tap_time_max = 20
var tap_time = tap_time_max

func enter() -> void:
	pass

func update(float) -> void:
	if player.is_on_floor():
		check_for_grounded_movement()
		check_for_idle()

func exit() -> void:
	pass


func _physics_process(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y -= player.gravity * delta
		var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
		var direction := (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() 
		#if tap_time > 0 and (Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right")):
			#player.velocity.x = direction.x * 10
			#player.velocity.z = direction.z * 10
		if direction:
			player.velocity.x = direction.x * (player.AIRTIME * player.AIR_SPEED)
			player.velocity.z = direction.z * (player.AIRTIME * player.AIR_SPEED)
			player.AIRTIME = player.AIRTIME * player.AIR_FRICTION
