extends Node3D

# VERY unfinished. This is supposed to fill in every square of the chess board, and will change it's
# graphic between the different pieces, depending on whether one is on this tile. It should also 
# bcome highlighted whenever the player has selected a piece, and is looking at where it could go. 



# Pieces:
#	WHITE		BLACK		TYPE
#	0			8			EMPTY
#	1			9			PAWN
#	2			10			BISHOP
#	3			11			ROOK
#	4			12			KNIGHT
#	5			13			QUEEN
#	6			14			KING




var board = get_parent()


var piece = 0;
var sprite;
var highlight;
var is_highlighted=false;
var x;
var y;

var texdict={}

var time_selected=0;
var timer=1;
var is_cursor_hover=false;

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	sprite = get_node("piece");
	highlight= get_node("highlight");
	highlight.modulate.a=0.1;
	pass # Replace with function body.

func set_piece(new_piece):
	piece = new_piece;
	
	_unhighlight()
	if piece==0 or piece==8:
		sprite.modulate.a=0;
	else:
		sprite.modulate.a=1;
		sprite.texture=get_parent().piecetex[new_piece];
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer=max(0,timer - delta*10);
	if(timer==0):
		if(is_cursor_hover):
			cursor_stop_hover()
			#print(get_parent().name);
			#get_parent().unhighlight_piece(self);
			
	pass
	
func cursor_hover(delta):
	is_cursor_hover=true;
	timer=1
	time_selected = time_selected+delta;
	rotation.y=sin(time_selected*10)/10;
	var ts = min(time_selected+1,1.2);
	
	scale=Vector3(ts, ts, ts);

func cursor_stop_hover():
	get_parent().unhighlight_piece(self);
	is_cursor_hover = false;
	timer=0;
	time_selected=0;
	scale=Vector3(1,1,1);
	rotation.y=0;



func _highlight():
	highlight.show()
	is_highlighted=true;
	
func _unhighlight():
	is_highlighted=false;
	highlight.hide()

