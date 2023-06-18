@tool
extends Node3D

@export_category("Resources")
@export var domino_scene: PackedScene

@export_category("Domino properties")
@export var domino_friction: float = Domino.default_friction
@export var domino_albedo_color: Color = Domino.default_color

@export_category("Triangle properties")
@export var domino_interval: float = 0.5
@export var domino_lines: int = 5
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
		
	for i in domino_lines:
		
		for j in i + 1:
			var domino_instance: Domino = domino_scene.instantiate()
			
			var start_z = - i * (domino_instance.width / 2) - i * margin_size / 2
			
			domino_instance.position.x -= (i + 1) * domino_interval
			
			domino_instance.position.z += start_z + j * (domino_instance.width + margin_size) 
			
			domino_instance.albedo_color_override = domino_albedo_color
			domino_instance.friction_override = domino_friction
			
			$Marker3D.add_child(domino_instance)
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
