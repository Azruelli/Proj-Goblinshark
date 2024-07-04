extends CharacterBody3D

var zealot_health_maximum := 100
var health = zealot_health_maximum

const zealot_ground_speed = 3.0
const zealot_transformed_speed = 8.0
const zealot_turn_speed = 2

var attack_able = 0
var zealot_awoken = 0 

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var ray_cast_3d: RayCast3D = $ZealotEyes/RayCast3D
@onready var player_pos: Player = $"../Player"
@onready var zealot_eyes: Node3D = $ZealotEyes



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

	move_and_slide()


func wake_up() -> void:
	if health < 100: 
		zealot_awoken = 1 
