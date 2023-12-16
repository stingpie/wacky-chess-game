extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
# These functions just pass the info that this box has been selected to the
# node3D which controlls the text characters. 
func on_look_at():
	get_parent().on_look_at()
	
func on_stop_look_at():
	get_parent().on_stop_look_at()
