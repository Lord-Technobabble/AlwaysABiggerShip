extends Component

@export var turret_stats: TurretStats

var _targeting_groups: Array[String] = []
var _barrels: Array[Node2D] = []
var _current_target: Node2D = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var barrels = $WeaponPivot/WeaponBarrels.get_children()
	for barrel in barrels:
		_barrels.append(barrel)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func track_target():
	if _current_target == null:
		return
	$WeaponPivot.look_at(_current_target.global_position)

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
