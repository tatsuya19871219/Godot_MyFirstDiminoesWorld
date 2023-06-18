@tool

class_name Domino

extends RigidBody3D

const default_height: float = 2.0
const default_width: float = 1.0
const default_tickness: float = 0.2
const default_friction: float = 0.5
const default_color: Color = Color.WHITE

@export_category("Shape parameters")
@export var height = default_height
@export var width = default_width
@export var tickness = default_tickness

@export_category("Physical parameters")
@export var friction_override = default_friction

@export_category("Apperance")
@export var albedo_color_override: Color


var sound_playable = true
var debug_mode = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var domino_mesh = $MeshInstance3D.mesh.duplicate(true)
	domino_mesh.size = Vector3(tickness, height, width)
	
	if albedo_color_override == null:
		domino_mesh.material.albedo_color = default_color
	else:
		domino_mesh.material.albedo_color = albedo_color_override
	
	$MeshInstance3D.mesh = domino_mesh
	$MeshInstance3D.position.y = height / 2
	
	var domino_collision: BoxShape3D = BoxShape3D.new()
	domino_collision.size = $MeshInstance3D.mesh.size
	$CollisionShape3D.shape = domino_collision
	
	$CollisionShape3D.position.y = height / 2
	
	$AudioStreamPlayer3D.position.y = height / 2
	
	center_of_mass.y = height / 2
	
	var physics_material = PhysicsMaterial.new()
	physics_material.friction = friction_override
	physics_material_override = physics_material


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	
	var target = body as RigidBody3D
	
	if target != null:
		
		call_deferred("set_contact_monitor", false)
		
		if sound_playable:
			$AudioStreamPlayer3D.play()
		
		if debug_mode:
			var material_overlay = StandardMaterial3D.new()
			material_overlay.albedo_color = Color.RED
			material_overlay.transparency = 1.0
			$MeshInstance3D.material_overlay = material_overlay
		
			await get_tree().create_timer(0.5).timeout
			$MeshInstance3D.material_overlay = null
	else:
		$MeshInstance3D.material_overlay = null
		


func disable_contact_monitor():
	call_deferred("set_contact_monitor", false)
	
func enable_contact_monitor():
	call_deferred("set_contact_monitor", true)
	
func set_sound_playable(value: bool):
	sound_playable = value
