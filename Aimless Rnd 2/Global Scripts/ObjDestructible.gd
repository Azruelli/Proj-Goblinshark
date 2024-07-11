extends Node

var health = 20

func _ready() -> void:
	add_to_group("Enemy")

func _process(delta: float) -> void:
	if health <= 0:
		queue_free()
