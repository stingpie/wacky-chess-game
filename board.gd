extends Node3D

# This controls the chess board. it copys a new tile for each square, and (in future) will do all 
# the actual chess logic. 

var mouse_over=false;
var tiles=[];
var selected_piece=null;

# Called when the node enters the scene tree for the first time.
func _ready():
	tiles.resize(8)
	for i in range(8):
		tiles[i]=[0,0,0,0, 0,0,0,0]
	
	for x in range(8):
		for y in range(8):
			var temp = get_node("../tile").duplicate()
			self.add_child(temp)
			temp.position.x = -x*0.25
			temp.position.z = -y*0.25
			temp.visible=true
			temp.x=x; temp.y=y;
			temp.get_child(0).get_child(0).shape.size.x=0.2
			temp.get_child(0).get_child(0).shape.size.z=0.2
			temp.get_child(0).get_child(0).shape.size.y=0.01
			tiles[x][y]=temp
			
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(selected_piece):
		selected_piece.cursor_hover(delta)
	pass





func on_look_at(piece):
	selected_piece=piece.get_parent();
	mouse_over=true;
	
func on_stop_look_at(piece):
	piece.get_parent().cursor_stop_hover();
	selected_piece=null;
	mouse_over = false;

