extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$MainCamera.current = true
	$CameraWork.play("camera_work")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_camera_work_animation_finished(anim_name):
	$BirdCamera.current = true
	$MainCamera.current = false
