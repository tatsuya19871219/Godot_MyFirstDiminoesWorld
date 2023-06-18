@tool
extends StaticBody3D

@export_category("Shape parameters")
@export var length = 3.0
@export var height = 2.0
@export var width = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var slope_mesh = $MeshInstance3D.mesh.duplicate(true)
	slope_mesh.size = Vector3(length, height, width)
	
	$MeshInstance3D.mesh = slope_mesh
	$MeshInstance3D.mesh.left_to_right = 1
	
	$MeshInstance3D.position.x = length / 2
	$MeshInstance3D.position.y = height / 2
	
	var slope_collision: ConvexPolygonShape3D = ConvexPolygonShape3D.new()
	
	var shape_points = []
	shape_points.append(Vector3(0, 0, -width/2))
	shape_points.append(Vector3(0, 0, width/2))
	shape_points.append(Vector3(length, 0, -width/2))
	shape_points.append(Vector3(length, 0, width/2))
	shape_points.append(Vector3(length, height, -width/2))
	shape_points.append(Vector3(length, height, width/2))
	
	slope_collision.points = shape_points
	
	$CollisionPolygon3D.shape = slope_collision

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
