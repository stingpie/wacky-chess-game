extends RayCast3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var prevtarget

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#get_child(0).position= target_position;
	var target = get_collider()
	if(target != prevtarget):
		if(target != null and target.has_method("on_look_at")):
			target.on_look_at();
		elif(prevtarget.has_method("on_stop_look_at") ):
			prevtarget.on_stop_look_at();
		
	prevtarget=target
	
	pass
