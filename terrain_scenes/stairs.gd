@tool

class_name Stairs

extends Node3D

@export_category("Resources")
@export var board_scene: PackedScene

@export_category("Shape parameters")
@export var step_size = 1.0
@export var step_height = 0.5
@export var step_width = 2.0

@export var number_of_steps = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in number_of_steps:
		var block: StaticBoard3D = board_scene.instantiate()
		
		block.length = step_size
		block.height = (i + 1) * step_height
		block.width = step_width
		
		block.position.x = i * step_size
		
		add_child(block)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
