@tool
extends StaticBody3D

@export_category("Shape parameters")
@export var tickness = 2.0
@export var width = 10.0
@export var depth = 10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var ground_mesh: BoxMesh = $MeshInstance3D.mesh.duplicate(true)
	
	ground_mesh.size = Vector3(width, tickness, depth)
	$MeshInstance3D.mesh = ground_mesh
	$MeshInstance3D.position.y = - tickness / 2
	
	var ground_collision: BoxShape3D = BoxShape3D.new()
	ground_collision.size = ground_mesh.size
	$CollisionShape3D.shape = ground_collision
	$CollisionShape3D.position.y = - tickness / 2
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
