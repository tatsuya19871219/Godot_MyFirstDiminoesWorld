@tool

extends Node3D

@export_category("Resources")
@export var domino_scene: PackedScene

@export_category("Domino properties")
@export var domino_friction: float = Domino.default_friction
@export var domino_albedo_color: Color = Domino.default_color

@export_category("Stairs properties")
@export var stairs_step_offset: float = 0.0 # [%]
@export var stairs_step_size: float = 1.0
@export var stairs_step_height: float = 0.5
@export var stairs_steps: int = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var domino_location: PathFollow3D = get_node("Path3D/PathFollow3D")	
	
	var current_progress_ratio = 0.0
	
	for i in stairs_steps:
		
		current_progress_ratio = (i as float + stairs_step_offset) / stairs_steps
		
		domino_location.progress_ratio = current_progress_ratio 
			
		var current_point = domino_location.position

		current_point.y = (i + 1) * stairs_step_height
		
		var domino_instance = domino_scene.instantiate()
		
		domino_instance.position = current_point
		
		domino_instance.rotation = domino_location.rotation
		domino_instance.rotation.y += PI / 2
		domino_instance.rotation.z = 0
		domino_instance.rotation.x = 0
		
		domino_instance.albedo_color_override = domino_albedo_color
		domino_instance.friction_override = domino_friction
		
		add_child(domino_instance)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
