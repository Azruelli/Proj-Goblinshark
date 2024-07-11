extends RigidBody3D

var Projectile_speed = 40
var motion = Vector3.FORWARD
@onready var player: Player = $Player

signal damage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		damage.emit()
