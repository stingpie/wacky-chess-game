extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_node("/root/Node3D/Player");
	var pxz = Vector2(player.position.x, player.position.z);
	var sxz = Vector2(self.position.x, self.position.z);
	var dir = atan2((sxz.x-pxz.x),(sxz.y-pxz.y));
	if(abs(dir - self.rotation.y)>0.1):
		self.rotate_y( (dir - self.rotation.y)*delta*5);
	pass
