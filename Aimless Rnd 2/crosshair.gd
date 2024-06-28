extends Control
class_name cross_hair

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _process(delta: float) -> void:
	_on_machine_gun_shot_fired()


func _on_machine_gun_shot_fired() -> void:
	if Input.is_action_just_pressed("Shoot"):
		animation_player.play("Blooming")
	else:
		animation_player.play("RESET")
