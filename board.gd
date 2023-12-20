extends Node3D

# This controls the chess board. it copys a new tile for each square, and (in future) will do all 
# the actual chess logic. 

var hover_sound = preload("res://Gangsta Paradise Choir  Sound Effect for editinghgc.mp3");
var audio_stream_player = AudioStreamPlayer.new();

var mouse_over=false;
var tiles=[];
var selected_piece=null;
var piecetex=[];
var piece_held=null;

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
	
	audio_stream_player.stream = hover_sound;
	audio_stream_player.name = "sound_effect"
	self.add_child(audio_stream_player);
	
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
				[0,3,0,0,0,0,0,0],
				[0,0,0,2,0,0,0,0],
				[0,0,0,0,0,5,0,0],  
				[1,1,1,1,1,1,1,1], 
				[3,4,2,6,5,2,4,3]];
	
	set_pieces(arr);
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(selected_piece):
		selected_piece.cursor_hover(delta)
		get_node("sound_effect").play();
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_E and selected_piece:
			if(not piece_held):
				piece_held=selected_piece;
			else:
				if(selected_piece.is_highlighted):
					selected_piece.set_piece(piece_held.piece);
					piece_held.set_piece(0);
					piece_held=null;
					
					for x in range(8):
						for y in range(8):
							tiles[x][y]._unhighlight()
				elif(selected_piece == piece_held):
					unhighlight_piece(selected_piece);
					piece_held=null;
			


func set_pieces(setup):
	for x in range(8):
		for y in range(8):
			tiles[x][y].set_piece(setup[y][x]);
	pass


func highlight_piece(piece):
	if(piece_held):
		return
	if(piece.piece==1): # W PAWN
		if(piece.y==6): # if passant is possible
			highlight_line(piece, 0,-1, 2);
		else:
			highlight_line(piece, 0,-1, 1);
	
	if(piece.piece == 2 or piece.piece == 10):
		highlight_line(piece, -1,-1, 8);
		highlight_line(piece, -1, 1, 8);
		highlight_line(piece,  1,-1, 8);
		highlight_line(piece,  1, 1, 8);
		
	if(piece.piece == 3 or piece.piece == 11):
		highlight_line(piece,  0,-1, 8);
		highlight_line(piece,  0, 1, 8);
		highlight_line(piece, -1, 0, 8);
		highlight_line(piece,  1, 0, 8);
		
	if(piece.piece == 4 or piece.piece == 12):
		highlight_line(piece, -1,-2, 1);
		highlight_line(piece, -2,-1, 1);
		highlight_line(piece,  1,-2, 1);
		highlight_line(piece,  2,-1, 1);
		highlight_line(piece,  1, 2, 1);
		highlight_line(piece,  2, 1, 1);
		highlight_line(piece, -1, 2, 1);
		highlight_line(piece, -2, 1, 1);
		
		
	if(piece.piece == 5 or piece.piece == 13):
		highlight_line(piece, -1,-1, 8);
		highlight_line(piece, -1, 1, 8);
		highlight_line(piece,  1,-1, 8);
		highlight_line(piece,  1, 1, 8);
		highlight_line(piece,  0,-1, 8);
		highlight_line(piece,  0, 1, 8);
		highlight_line(piece, -1, 0, 8);
		highlight_line(piece,  1, 0, 8);
		
	if(piece.piece == 6 or piece.piece == 14):
		highlight_line(piece, -1,-1, 1);
		highlight_line(piece, -1, 1, 1);
		highlight_line(piece,  1,-1, 1);
		highlight_line(piece,  1, 1, 1);
		highlight_line(piece,  0,-1, 1);
		highlight_line(piece,  0, 1, 1);
		highlight_line(piece, -1, 0, 1);
		highlight_line(piece,  1, 0, 1);

	if(piece.piece==9): # B PAWN
		if(piece.y==1): # if passant is possible
			highlight_line(piece, 0,1, 2);
		else:
			highlight_line(piece, 0,1, 1);






func unhighlight_piece(piece):
	if(piece_held):
		return
	
	if(piece.piece==1): # W PAWN
		if(piece.y==6): # if passant is possible
			unhighlight_line(piece, 0,-1, 2);
		else:
			unhighlight_line(piece, 0,-1, 1);
	
	if(piece.piece == 2 or piece.piece == 10):
		unhighlight_line(piece, -1,-1, 8);
		unhighlight_line(piece, -1, 1, 8);
		unhighlight_line(piece,  1,-1, 8);
		unhighlight_line(piece,  1, 1, 8);
		
	if(piece.piece == 3 or piece.piece == 11):
		unhighlight_line(piece,  0,-1, 8);
		unhighlight_line(piece,  0, 1, 8);
		unhighlight_line(piece, -1, 0, 8);
		unhighlight_line(piece,  1, 0, 8);
		
	if(piece.piece == 4 or piece.piece == 12):
		unhighlight_line(piece, -1,-2, 1);
		unhighlight_line(piece, -2,-1, 1);
		unhighlight_line(piece,  1,-2, 1);
		unhighlight_line(piece,  2,-1, 1);
		unhighlight_line(piece,  1, 2, 1);
		unhighlight_line(piece,  2, 1, 1);
		unhighlight_line(piece, -1, 2, 1);
		unhighlight_line(piece, -2, 1, 1);
		
		
	if(piece.piece == 5 or piece.piece == 13):
		unhighlight_line(piece, -1,-1, 8);
		unhighlight_line(piece, -1, 1, 8);
		unhighlight_line(piece,  1,-1, 8);
		unhighlight_line(piece,  1, 1, 8);
		unhighlight_line(piece,  0,-1, 8);
		unhighlight_line(piece,  0, 1, 8);
		unhighlight_line(piece, -1, 0, 8);
		unhighlight_line(piece,  1, 0, 8);
		
	if(piece.piece == 6 or piece.piece == 14):
		unhighlight_line(piece, -1,-1, 1);
		unhighlight_line(piece, -1, 1, 1);
		unhighlight_line(piece,  1,-1, 1);
		unhighlight_line(piece,  1, 1, 1);
		unhighlight_line(piece,  0,-1, 1);
		unhighlight_line(piece,  0, 1, 1);
		unhighlight_line(piece, -1, 0, 1);
		unhighlight_line(piece,  1, 0, 1);

	if(piece.piece==9): # B PAWN
		if(piece.y==1): # if passant is possible
			unhighlight_line(piece, 0,1, 2);
		else:
			unhighlight_line(piece, 0,1, 1);
	pass;
	




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

func highlight_line(piece, dx, dy, length):
	var px = piece.x;
	var py = piece.y;
	var type = piece.piece;
	
	
	for i in range(1,length+1):
		if(px+dx*i>7 or px+dx*i<0 or py+dy*i>7 or py+dy*i<0):
			return; 
			
		if(type>=8):
			if(tiles[px+dx*i][py+dy*i].piece>8):
				return;
			elif(tiles[px+dx*i][py+dy*i].piece<8 && tiles[px+dx*i][py+dy*i].piece!=0):
				tiles[px+dx*i][py+dy*i]._highlight();
				return;
			else:
				tiles[px+dx*i][py+dy*i]._highlight();
				
		if(type<8):
			if(tiles[px+dx*i][py+dy*i].piece<8 && tiles[px+dx*i][py+dy*i].piece>0):
				return;
			elif(tiles[px+dx*i][py+dy*i].piece>8 && tiles[px+dx*i][py+dy*i].piece!=0):
				tiles[px+dx*i][py+dy*i]._highlight();
				return;
			else:
				tiles[px+dx*i][py+dy*i]._highlight();
	pass
	
func unhighlight_line(piece, dx, dy, length):
	
	var px = piece.x;
	var py = piece.y;
	var type = piece.piece;
	
	for i in range(1,length+1):
		if(px+dx*i>7 or px+dx*i<0 or py+dy*i>7 or py+dy*i<0):
			return; 
			
		if(type>=8):
			if(tiles[px+dx*i][py+dy*i].piece>8):
				return;
			elif(tiles[px+dx*i][py+dy*i].piece<8 && tiles[px+dx*i][py+dy*i].piece!=0):
				tiles[px+dx*i][py+dy*i]._unhighlight();
				return;
			else:
				tiles[px+dx*i][py+dy*i]._unhighlight();
				
		if(type<8):
			if(tiles[px+dx*i][py+dy*i].piece<8 && tiles[px+dx*i][py+dy*i].piece>0):
				return;
			elif(tiles[px+dx*i][py+dy*i].piece>8 && tiles[px+dx*i][py+dy*i].piece!=0):
				tiles[px+dx*i][py+dy*i]._unhighlight();
				return;
			else:
				tiles[px+dx*i][py+dy*i]._unhighlight();
	pass
