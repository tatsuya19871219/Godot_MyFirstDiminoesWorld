@tool
extends Node3D

signal is_built

@export_category("Resources")
@export var domino_scene: PackedScene

@export_category("Domino properties")
@export var domino_tickness: float = Domino.default_tickness
@export var domino_friction: float = Domino.default_friction
@export var domino_albedo_color: Color = Domino.default_color

@export_category("Tower properties")
@export var tower_height = 3
@export var placing_await_time = 0.2

@onready var margin_size = 0.05 # domino_tickness * 0.25


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var dominoes: Array = []
	
	var i = 0
	
	var domino_height = Domino.default_height
	
	var lane_interval = domino_height
	var floor_interval = domino_height
	
	while i < tower_height:
		
		var lane_start_x = i * lane_interval / 2
		var floor_start_x = i * floor_interval / 2
		
		var domino_lane_length = (tower_height - i) + 1
		var domino_floor_length = domino_lane_length - 1
		
		for j in domino_lane_length:
			var domino = domino_scene.instantiate()
			
			domino.tickness = domino_tickness
			
			domino.position.x += lane_start_x + j * (lane_interval + margin_size)
			domino.position.y += i * domino_height + i * domino_tickness
			
			domino.albedo_color_override = domino_albedo_color
			domino.friction_override = domino_friction
			
			domino.disable_contact_monitor()
			domino.set_sound_playable(false)
			
			dominoes.append(domino)
			
			$Marker3D.add_child(domino)
			
			if not Engine.is_editor_hint():
				await get_tree().create_timer(placing_await_time).timeout
			
		for j in domino_floor_length:
			var domino = domino_scene.instantiate()
			
			domino.tickness = domino_tickness
			
			domino.position.x += floor_start_x + j * (floor_interval + margin_size) + margin_size / 2
			domino.position.y += (i + 1) * domino_height + i * domino_tickness + domino_tickness / 2
			
			domino.rotation.z = - PI / 2
			
			domino.albedo_color_override = domino_albedo_color
			domino.friction_override = domino_friction
			
			domino.disable_contact_monitor()
			domino.set_sound_playable(false)
			
			dominoes.append(domino)
			
			$Marker3D.add_child(domino)
			
			if not Engine.is_editor_hint():
				await get_tree().create_timer(placing_await_time).timeout

		i += 1
	
	print("Tower building is completed")
	
	await get_tree().create_timer(2.0).timeout
	
	is_built.emit()
	
	for domino in dominoes:
		#domino.set_sound_playable(true)
		domino.enable_contact_monitor()
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
