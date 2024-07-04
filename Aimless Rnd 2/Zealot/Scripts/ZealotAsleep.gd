extends ZealotState
class_name ZealotAsleep

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if zealot.health != 100:
		Enter_Awake()

func process(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
