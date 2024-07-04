class_name Idle
extends PlayerState



# Called when the node enters the scene tree for the first time.
func enter() -> void:
	print("idle")

func update(float) -> void:
	if not player.is_on_floor():
		Transitioned.emit("player_air")

	#if player.is_on_floor():
		#if player.input_event == Input.get("Forward") or Input.get("Backward") or Input.get("Left") or Input.get("Right"):
			#Transitioned.emit("player_walking")

func exit() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
