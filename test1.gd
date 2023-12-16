extends Node3D
#
#var textbox 
## Called when the node enters the scene tree for the first time.
#func _ready():
#
#	textbox = self.find_child("Node3D3")
#	textbox.new_line("THIS IS REGULAR TEXT\nWILL I JUST HAVE TO\nMAKE ALL THE LINES\nTHE SAME LENGTH\n");
#
#	pass # Replace with function body.
#
#var did_it=false
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	#print(Time.get_ticks_msec())
#	if(Time.get_ticks_msec()>2000 && !did_it):
#		textbox.show_text()
#		did_it=true
#	pass
