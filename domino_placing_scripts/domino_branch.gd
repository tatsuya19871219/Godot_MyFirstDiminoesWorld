@tool
extends Node3D

@export_category("Resources")
@export var domino_scene: PackedScene

@export_category("Domino properties")
@export var domino_friction: float = Domino.default_friction
@export var domino_albedo_color_1: Color = Domino.default_color
@export var domino_albedo_color_2: Color = Domino.default_color

@export_category("Branch properties")
@export var branch_angle: float = PI / 1.5

@export var branch_offset: float = 0.5

@export var margin_size: float = 0.05

@export_node_path("PathFollow3D") var last_domino_location_path


# Called when the node enters the scene tree for the first time.
func _ready():
	
	if domino_scene == null:
		return
	
	var last_rotation
	
	# get last rotation
	if last_domino_location_path == null:
		last_rotation = Vector3.ZERO
	else:
		var last_domino_location = get_node(last_domino_location_path)
		last_domino_location.progress_ratio = 1.0
		last_rotation = last_domino_location.rotation
		
		$Marker3D.rotation = last_rotation
		$Marker3D.rotation.y += PI / 2
	
	var domino_instance1: Domino = domino_scene.instantiate()
	var domino_instance2: Domino = domino_scene.instantiate()
	
	var domino_width = domino_instance1.width
	
	var phi = (PI - branch_angle) / 2
	var r = domino_width / 2 + (margin_size + domino_instance1.tickness) / 2 
	
	domino_instance1.rotation.y += phi
	domino_instance2.rotation.y -= phi
	
	domino_instance1.position.z = r * cos(phi)
	domino_instance2.position.z = - r * cos(phi)
	
	domino_instance1.position.x = - r * sin(phi) - branch_offset
	domino_instance2.position.x = - r * sin(phi) - branch_offset
	
	domino_instance1.albedo_color_override = domino_albedo_color_1
	domino_instance2.albedo_color_override = domino_albedo_color_2
	
	domino_instance1.friction_override = domino_friction
	domino_instance2.friction_override = domino_friction
	
	$Marker3D.add_child(domino_instance1)
	$Marker3D.add_child(domino_instance2)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
