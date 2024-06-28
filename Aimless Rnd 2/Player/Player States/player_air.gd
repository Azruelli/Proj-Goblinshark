extends PlayerState
class_name Air

func enter() -> void:
	pass

func update(float) -> void:
	if player.is_on_floor() and player.velocity.z and player.velocity.x == 0:
		Transitioned.emit("player_idle")

	if player.is_on_floor():
		if player.input_event == Input.get("Forward") or Input.get("Backward") or Input.get("Left") or Input.get("Right"):
			Transitioned.emit("player_walking")

func exit() -> void:
	pass


func _physics_process(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y -= player.gravity * delta
