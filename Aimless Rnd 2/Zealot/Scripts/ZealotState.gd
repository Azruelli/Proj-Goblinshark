extends State
class_name ZealotState

@export var zealot = CharacterBody3D

func _ready() -> void:
	pass

func Enter_Awake() -> void:
	if zealot.health < 100:
		Transitioned.emit("ZealotAwake")

func Enter_Attack() -> void:
	if zealot.attack_able == 1:
		Transitioned.emit("ZealotAttacking")
