extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



# call node3D parent's (tile) on_look_at function, when this hitbox is looked at. 
func on_look_at():
	if(get_parent().get_parent().has_method("on_look_at")):
		get_parent().get_parent().on_look_at(self)
	
func on_stop_look_at():
	if(get_parent().get_parent().has_method("on_stop_look_at")):
		get_parent().get_parent().on_stop_look_at(self)
