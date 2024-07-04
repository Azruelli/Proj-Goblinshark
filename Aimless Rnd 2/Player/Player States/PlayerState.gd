extends State
class_name PlayerState

@export var player: Player

func _ready() -> void:
	pass

func check_for_jump_input() -> void:
	if player.is_on_floor() and Input.is_action_just_pressed("Jump"):
		player.velocity.y = player.JUMP_VELOCITY
		Transitioned.emit("player_air")

func check_for_grounded_movement() -> void:
	if player.is_on_floor():
		var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
		var direction := (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() 
		#if player.input_event == Input.get("Forward") or Input.get("Backward") or Input.get("Left") or Input.get("Right"):
		if direction:
			Transitioned.emit("player_walking")


func check_for_idle():
	if player.velocity == Vector3.ZERO:
		Transitioned.emit("player_idle")

func check_for_air_movement():
	if not player.is_on_floor():
		Transitioned.emit("player_air")
