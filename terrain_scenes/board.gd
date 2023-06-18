@tool

class_name StaticBoard3D

extends StaticBody3D

@export_category("Shape parameters")
@export var length = 3.0
@export var height = 0.5
@export var width = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var board_mesh = $MeshInstance3D.mesh.duplicate(true)
	board_mesh.size = Vector3(length, height, width)
	$MeshInstance3D.mesh = board_mesh

	$MeshInstance3D.position.x = length / 2
	$MeshInstance3D.position.y = height / 2
	
	var board_collision: BoxShape3D = BoxShape3D.new()
	board_collision.size = board_mesh.size
	$CollisionShape3D.shape = board_collision
	
	$CollisionShape3D.position.x = length / 2
	$CollisionShape3D.position.y = height / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
