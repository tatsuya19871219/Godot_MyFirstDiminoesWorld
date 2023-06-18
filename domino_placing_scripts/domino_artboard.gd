@tool
extends Node3D

@export_category("Resources")
@export var domino_scene: PackedScene

@export_category("Domino properties")
@export var domino_friction: float = Domino.default_friction
@export var front_domino_albedo_color: Color = Domino.default_color
@export var back_domino_albedo_color: Color = Color.BLACK

@export_category("Art properties")
@export var domino_interval: float = 1.5
@export var margin_size: float = 0.05
@export var art_flip: bool = false

@export_file("*.txt") var blueprint

# Called when the node enters the scene tree for the first time.
func _ready():
	if domino_scene == null:
		return
		
	var file = load_blueprint(blueprint)
	
	var lines: Array
	
	while !file.eof_reached():
		
		var line = file.get_csv_line(",")
		if !art_flip:
			lines.append(line)
		else:
			
			for k in line.size():
				
				if lines.size() < line.size():
					lines.append([] as Array)
					
				lines[k].append(line[k])
				
	
	var lines_size = lines.size()
	for i in lines_size:
		var line = lines[i]
		
		var s = line.size()
		var debug_line = ""
		for j in s:
			
			var domino_albedo_color: Color
			
			match line[j]:
				"_", " _":
					debug_line += "_"
					
					domino_albedo_color = back_domino_albedo_color
					
					
				"o", " o":
					debug_line += "o"
					
					domino_albedo_color = front_domino_albedo_color
					
					
				_:
					debug_line += "?"
					continue
				
			var domino_instance: RigidBody3D = domino_scene.instantiate()
					
			domino_instance.position.x += (j + 1) * domino_interval
			domino_instance.position.z += i * (domino_instance.width + margin_size)
			
			domino_instance.albedo_color_override = domino_albedo_color
			domino_instance.friction_override = domino_friction	
			
			$Marker3D.add_child(domino_instance)
			
		print(debug_line)
		
		
	
func load_blueprint(filepath):
	
	var file = FileAccess.open(filepath, FileAccess.READ)
	return file
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
