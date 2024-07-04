class_name Walking
extends PlayerState

var tap_time_max = 20
var tap_time = tap_time_max


# Called when the node enters the scene tree for the first time.
func enter() -> void:
	print("walking")

func update(float) -> void:
	if not player.is_on_floor():
		Transitioned.emit("player_air")


	if player.is_on_floor():
		check_for_idle()
		check_for_jump_input()


func exit() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if player.is_on_floor():
		player.AIRTIME = player.AIRTIME_MAXIMUM
		if direction:
			player.velocity.x = lerp(player.velocity.x, direction.x * player.SPEED, player.SPEED * delta * .5)
			player.velocity.z = lerp(player.velocity.z, direction.z * player.SPEED, player.SPEED * delta * .5)
			tap_time = tap_time_max
		else:
			player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED * delta)
			player.velocity.z = move_toward(player.velocity.z, 0, player.SPEED * delta)
			tap_time = tap_time - 1
		
