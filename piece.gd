extends Node3D

# VERY unfinished. This is supposed to fill in every square of the chess board, and will change it's
# graphic between the different pieces, depending on whether one is on this tile. It should also 
# bcome highlighted whenever the player has selected a piece, and is looking at where it could go. 






var board = get_parent()

enum {EMPTY, WPAWN, WKINGHT, WBISHOP, WQUEEN, WKING, WROOK, BPAWN, BKINGHT, BBISHOP, BQUEEN, BKING, BROOK}
var piece = EMPTY;
var sprite;
var highlight;
var x;
var y;

var time_selected=0;
var timer=1;

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("piece");
	highlight= get_node("highlight");
	pass # Replace with function body.

func set_piece(new_piece):
	piece = new_piece;
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer=max(0,timer - delta*10);
	if(timer==0):
		cursor_stop_hover()
	pass
	
func cursor_hover(delta):
	timer=1
	time_selected = time_selected+delta;
	rotation.y=sin(time_selected*10)/10;
	var ts = min(time_selected+1,1.2);
	
	scale=Vector3(ts, ts, ts);
	
func cursor_stop_hover():
	timer=0;
	time_selected=0;
	scale=Vector3(1,1,1);
	rotation.y=0;

