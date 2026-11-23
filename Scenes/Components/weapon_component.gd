extends Component

@export var turret_stats: TurretStats

signal shot(from: Vector2, \
			rotation: float, \
			shot: ShotStats,
			target: Node2D)

var _targeting_groups: Array[String] = ["ship"]
var _barrels: Array[Node2D] = []
var _current_target: Node2D = null
var can_fire = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var barrels = $WeaponPivot/WeaponBarrels.get_children()
	for barrel in barrels:
		_barrels.append(barrel)
	super._ready()
	$WeaponCooldown.wait_time = turret_stats.shots_per_minute / 60

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_target()
	track_target()
	try_shoot()

func track_target():
	if _current_target == null:
		return
	$WeaponPivot.look_at(_current_target.global_position)

func try_shoot():
	if !can_fire:
		return
	
	if _current_target == null:
		return
	
	var target_distance = global_position.distance_to(_current_target.global_position)
	if target_distance > turret_stats.shot_stats.range:
		return
		
	shoot()
	
func shoot():
	print("pew")
	can_fire = false
	$WeaponCooldown.start()

func set_target():
	var targets = []
	for group in _targeting_groups:
		targets.append_array(get_tree().get_nodes_in_group(group))
	
	var closest_dist = INF
	var closest_comp: Component = null
	for target in targets:
		if target is not Ship:
			continue
		var target_ship: Ship = target
		var target_comp = target_ship.get_closest_component(global_position)
		var current_dist = (global_position - target_comp.global_position).length_squared()
		
		if current_dist < closest_dist:
			current_dist = closest_dist
			closest_comp = target_comp
	
	_current_target = closest_comp


func _on_weapon_cooldown_timeout() -> void:
	can_fire = true
