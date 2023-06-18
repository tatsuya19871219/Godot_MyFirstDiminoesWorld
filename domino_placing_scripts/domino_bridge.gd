@tool
extends Node3D

@export_category("Resources")
@export var domino_scene: PackedScene

@export_category("Domino properties")
@export var domino_friction: float = Domino.default_friction
@export var domino_albedo_color: Color = Domino.default_color

@export_category("Bridge properties")
@export var domino_interval: float = 0.5
@export var bridge_height: int = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	if domino_scene == null:
		return
		
	var my_domino_path: Path3D = get_node("DominoPath")
	var my_domino_location: PathFollow3D = get_node("DominoPath/DominoLocation")
	
	# head
	for i in bridge_height:
		my_domino_location.progress = i as float * domino_interval
		
		var domino_instance = domino_scene.instantiate()
		
		domino_instance.position = my_domino_location.position
		domino_instance.height *= (i + 1)
		
		domino_instance.rotation = my_domino_location.rotation
		domino_instance.rotation.y += PI / 2
		
		domino_instance.albedo_color_override = domino_albedo_color
		domino_instance.friction_override = domino_friction
		
		add_child(domino_instance)

	var total_length = my_domino_path.curve.get_baked_length()
	
	# tail
	for i in bridge_height:
		
		my_domino_location.progress = total_length - (i as float * domino_interval)
		
		var domino_instance = domino_scene.instantiate()
		
		domino_instance.position = my_domino_location.position
		domino_instance.height *= (i + 1)
		
		domino_instance.rotation = my_domino_location.rotation
		domino_instance.rotation.y += PI / 2
		
		domino_instance.albedo_color_override = domino_albedo_color
		domino_instance.friction_override = domino_friction
		
		add_child(domino_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
