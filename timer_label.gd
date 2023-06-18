extends Label

var elapsed = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	elapsed += delta
	
	set_text("Time elapsed [sec]: %3.2f " % elapsed)
