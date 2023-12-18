extends Node3D

# This controls the chess board. it copys a new tile for each square, and (in future) will do all 
# the actual chess logic. 

var mouse_over=false;
var tiles=[];
var selected_piece=null;
var piecetex=[];

# Pieces:
#	WHITE		BLACK		TYPE
#	0			8			EMPTY
#	1			9			PAWN
#	2			10			BISHOP
#	3			11			ROOK
#	4			12			KNIGHT
#	5			13			QUEEN
#	6			14			KING









# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in "APBRNQKAAPBRNQK":
		load_textures(i)
	
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
			
	
	var arr=[	[11,12,10,13,14,10,12,11], 
				[9,9,9,9,9,9,9,9],
				[0,0,0,0,0,0,0,0],
				[0,0,0,0,0,0,0,0],
				[0,0,0,0,1,9,0,0],
				[0,0,0,4,0,0,9,0],  
				[1,1,1,1,1,1,1,1], 
				[3,4,2,6,5,2,4,3]];
	
	set_pieces(arr);
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(selected_piece):
		selected_piece.cursor_hover(delta)
	pass

func set_pieces(setup):
	for x in range(8):
		for y in range(8):
			tiles[x][y].set_piece(setup[y][x]);
	pass


func highlight_piece(piece):
	if(piece.piece==1): # W PAWN
		if(tiles[piece.x][piece.y-1].piece>=8 or tiles[piece.x][piece.y-1].piece==0):
			tiles[piece.x][piece.y-1].highlight.show();
			if(piece.y==6): # if passant is possible
				tiles[piece.x][piece.y-2].highlight.show();
	
	
	
	
	
	if(piece.piece==9): # B PAWN
		tiles[piece.x][piece.y+1].highlight.show();
		if(piece.y==1): # if passant is possible
			tiles[piece.x][piece.y+2].highlight.show();






func unhighlight_piece(piece):
	if(piece.piece==1): # W PAWN
		tiles[piece.x][piece.y-1].highlight.hide();
		if(piece.y==6): # if passant is possible
			tiles[piece.x][piece.y-2].highlight.hide();
	
	
	
	
	
	if(piece.piece==9): # B PAWN
		tiles[piece.x][piece.y+1].highlight.hide();
		if(piece.y==1): # if passant is possible
			tiles[piece.x][piece.y+2].highlight.hide();
	




func on_look_at(piece):
	selected_piece=piece.get_parent();
	highlight_piece(selected_piece);
	mouse_over=true;
	
func on_stop_look_at(piece):
	#unhighlight_piece(piece);
	piece.get_parent().cursor_stop_hover();
	selected_piece=null;
	mouse_over = false;

func load_textures(char):
	var image = Image.load_from_file("res://sprites//text//" + char +".png")
	var texture = ImageTexture.create_from_image(image)
	piecetex.append(texture)


