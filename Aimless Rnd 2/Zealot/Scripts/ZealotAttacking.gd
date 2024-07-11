extends ZealotState
class_name ZealotAttacking

@onready var player: Player = $Player
@onready var melee_distance: Area3D = $"../../Melee Distance"
var projectile = preload("res://zealot_projectile.tscn")



func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func process(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	var ProjectileDirection = (zealot.zealot_eyes.global_transform.origin).normalized()
	#if zealot.attack_able == 1:
		#if melee_able == true:
			#pass
		#else: 
			#fire_projectile(ProjectileDirection)

func distance_check() -> void:
	pass

func fire_projectile(Dir: Vector3) -> void:
	var world = get_tree().get_root()
	var projectile_instance = projectile.instantiate()
	world.add_child(projectile_instance)
	
	projectile_instance.set_global_transform(player)
	projectile_instance.set_linear_velocity(Dir * $zealot_projectile.Projectile_speed)

func _on_melee_distance_body_entered(body: Node3D) -> void:
	if body is Player:
		zealot.melee_able = true
		print("melee active")

func _on_melee_distance_body_exited(body: Node3D) -> void:
	if body is Player:
		zealot.melee_able = false
		print("melee inactive")
