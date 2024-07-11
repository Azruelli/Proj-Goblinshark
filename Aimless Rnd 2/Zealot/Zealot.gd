extends CharacterBody3D

var zealot_health_maximum := 100
var health = zealot_health_maximum

const zealot_ground_speed = 3.0
const zealot_transformed_speed = 8.0
const zealot_turn_speed = 2

var attack_able = 0
var melee_able = false
var zealot_awoken = 0 

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var ray_cast_3d: RayCast3D = $ZealotEyes/RayCast3D
@onready var player_pos: Player = $"../Player"
@onready var zealot_eyes: Node3D = $ZealotEyes
@onready var zealot_projectile: Node3D = $"."
@onready var projectile = preload("res://zealot_projectile.tscn")

var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health <= 0:
		queue_free()
	wake_up()

func _on_state_timer_timeout() -> void:
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	zealot_eyes.look_at(player_pos.global_transform.origin, Vector3.UP)
	rotate_y(deg_to_rad(zealot_eyes.rotation.y * zealot_turn_speed))
	#var direction_to_player = global_position.direction_to(player_pos.global_position)
	#ray_cast_3d.target_position = direction_to_player
	#ray_cast_3d.force_raycast_update()
	#if ray_cast_3d.is_colliding():
		#var check_collider = ray_cast_3d.get_collider()
		#if check_collider.is_in_group("player"):
			#print("player seen")
		#else:
			#check_collider = null
			#print("don't see")
	var fire_direction = (zealot_eyes.global_transform.origin).normalized()
	if attack_able == 1:
		if melee_able == true:
			pass
		if melee_able == false:
			fire_projectile(fire_direction)
			print("Projectile fired")

	move_and_slide()


func wake_up() -> void:
	if health < 100: 
		zealot_awoken = 1 

func fire_projectile(Dir: Vector3) -> void:
	var world = get_tree().get_root()
	var projectile_instance = projectile.instantiate()
	world.add_child(projectile_instance)
	
	projectile_instance.set_global_transform(player.global_transform)
	projectile_instance.set_linear_velocity(Dir * 40)
