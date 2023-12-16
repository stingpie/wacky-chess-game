extends Node3D
var conversation 

# Called when the node enters the scene tree for the first time.
func _ready():
	conversation =get_node("conversation")

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var player = get_node("/root/Node3D/Player");
	var pxz = Vector2(player.position.x, player.position.z);
	var sxz = Vector2(self.position.x, self.position.z);
	var dir = atan((pxz.x-sxz.x)/(pxz.y-sxz.y));
	if(abs(dir - self.rotation.y)>0.1):
		self.rotate_y( (dir - self.rotation.y)*delta*5);
	pass




func _on_area_3d_body_entered(body):
	conversation.trigger_conversation("PSST... I'M A LAMP\nDON'T TELL ANYBODY!")
	pass # Replace with function body.


func _on_area_3d_body_exited(body):
	conversation.leave_conversation()
	
	pass # Replace with function body.
