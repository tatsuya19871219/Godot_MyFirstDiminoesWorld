@tool
extends Node3D

@export_category("Resources")
@export var domino_scene: PackedScene

@export_category("Domino properties")
@export var domino_friction: float = Domino.default_friction
@export var domino_albedo_color: Color = Domino.default_color

@export_category("Curve properties")
@export var domino_interval: float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if domino_scene == null:
		return
		
	var my_domino_path: Path3D = get_node("DominoPath")
	var my_domino_location: PathFollow3D = get_node("DominoPath/DominoLocation")
	
	var max_counts: int = my_domino_path.curve.get_baked_length() / domino_interval

	for i in max_counts + 1:
			
		var domino_instance: RigidBody3D = domino_scene.instantiate()
		
		my_domino_location.progress_ratio = i as float / max_counts
		
		domino_instance.position = my_domino_location.position
		
		domino_instance.rotation = my_domino_location.rotation
		domino_instance.rotation.y += PI / 2
		
		domino_instance.albedo_color_override = domino_albedo_color
		
		domino_instance.friction_override = domino_friction
		
		add_child(domino_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
