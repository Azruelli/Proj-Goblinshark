extends ZealotState
class_name ZealotAwake

var random_mode = 1 
var randomx_direction = 1
var randomz_direction = 1 
@onready var state_timer: Timer = $"../../StateTimer"
var call_time_max = 120
var call_time = call_time_max

func enter() -> void:
	pass

func update(float) -> void:
	_on_state_timer_timeout()

func exit() -> void:
	pass

#Zealot navigation base for naviagation agent to build on baked navmesh
func _process(delta: float) -> void:
	zealot.navigation_agent_3d.target_position = zealot.player.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if zealot.zealot_awoken == 1:
		if random_mode == 1:
			walking()
		if random_mode == 2:
			follow()
		call_time = call_time - 1
		if call_time <= 0:
			non_signal_timer()
			call_time = call_time_max
		if zealot.attack_able == 1:
			Enter_Attack()


func walking() -> void:
	var next_position = zealot.navigation_agent_3d.get_next_path_position()
	var direction = zealot.global_position.direction_to(next_position)
	
	if direction:
		zealot.velocity.x = direction.x * zealot.zealot_ground_speed
		zealot.velocity.z = direction.z * zealot.zealot_ground_speed
	else:
		zealot.velocity.x = move_toward(zealot.velocity.x, 0, zealot.zealot_ground_speed)
		zealot.velocity.z = move_toward(zealot.velocity.x, 0, zealot.zealot_ground_speed)


func follow() -> void:
	var comprehensive_position = zealot.navigation_agent_3d.get_next_path_position()
	var direction = zealot.global_position.direction_to(comprehensive_position)
	
	if direction:
		zealot.velocity.x = direction.x * zealot.zealot_ground_speed * randomx_direction
		zealot.velocity.z = direction.z * zealot.zealot_ground_speed * randomz_direction
	else:
		zealot.velocity.x = move_toward(zealot.velocity.x, 0, zealot.zealot_ground_speed)
		zealot.velocity.z = move_toward(zealot.velocity.x, 0, zealot.zealot_ground_speed)

func non_signal_timer() -> void:
	if call_time <= 0:
		random_mode = randi_range(1, 2)
		randomx_direction = randi_range(1, -1)
		randomz_direction = randi_range(1, -1)


func _on_state_timer_timeout() -> void:
	if zealot.ray_cast_3d.is_colliding():
		var check_target = zealot.ray_cast_3d.get_collider()
		if check_target.is_in_group("player"):
			zealot.attack_able = 1
