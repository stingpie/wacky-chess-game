extends Node3D

# This (so far) is the most complicated piece of code in the game. It manages the display of 
# each character, such as the slight swaying, their appearing & disapearing animation. 
# The additional functions (AKA. not _ready() and _process()) all set flags which tell _process()
# which animation to play. 

# _ready(): Called automatically, loads textures. (TODO: put all characters into a single texture
# and mask out the correct letter.)

# _process(): Called automatically, performs all animations. The other functions are called by
# either the StaticBody3D child of this node, or the node3D parent (called conversation).

# fade(): tells _process() to begin fading the text. 

# clear_text(): Deletes all characters. This is sudden, so it's only used if the characters are
# already invisible, or if the conversation enters an invalid state (can be caused by the player
# leaving and entering the conv while an animation is playing. ) 

# show_text(): triggers the appearing animation of the text. new_line() should be called first. 

# new_line(): Creates the char sprites and loads the line that will be displayed. show_text() is 
# called after this function to actually play the appearing animation & show the text. 

var mousebox
var font
# Called when the node enters the scene tree for the first time.
func _ready():
	#mousebox = self.get_child(0).get_child(0)
	mousebox = get_child(0)
	font = load("res://sprites/text2/ResizedSheet1.png")
	
	for i in "ABCDEFGHIJKLMNOPQRSTUVWXYZ":
		load_textures(i)
	mousebox.get_child(0).shape.size = Vector3(0,0,0)
	texdict["."]=ImageTexture.create_from_image( Image.load_from_file("res://sprites//text//period.png") )
	texdict["!"]=ImageTexture.create_from_image( Image.load_from_file("res://sprites//text//exclaim.png") )
	texdict["?"]=ImageTexture.create_from_image( Image.load_from_file("res://sprites//text//question.png") )
	texdict[","]=ImageTexture.create_from_image( Image.load_from_file("res://sprites//text//comma.png") )
	texdict["'"]=ImageTexture.create_from_image( Image.load_from_file("res://sprites//text//apostrophe.png") )
	texdict["\""]=ImageTexture.create_from_image( Image.load_from_file("res://sprites//text//qoute.png") )
	
	pass # Replace with function body.



var char_size=0.15;
var chars=[]
var char_offsets=[]
var new_chars=false
var fading=false
var st_time=0
var texdict={}

var mouse_hover=0;
var maxwidth=0;
var maxheight=0;
var mouse_over=false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(fading):
		for i in range(chars.size()):
			if(i<chars.size()):
				chars[i].modulate.a-= delta
			
				if(chars[i].modulate.a<=0):
					
					chars[i].queue_free()
					chars.remove_at(i)
					
		if(chars.size()==0):
			fading=false
			for i in self.get_children():
				if i is Sprite3D:
					i.queue_free()
	
	
	if(new_chars): #have the letters grow as the character speaks them.
		var over=true
		for i in range(chars.size()):
			var dif = (Time.get_ticks_msec() - st_time)
			
			var z = min(max(0,dif/2000.0 - 0.2*i / chars.size()), char_size)

			if(z<char_size-0.0001):
				over = false
				
				chars[i].scale =  Vector3(z,z,z)
				
				chars[i].position.y = max(0,char_offsets[i] + sin(7*(dif/2000.0 - 0.2*i/chars.size())*3.1415))/5.0 + char_offsets[i]
				
			
		if(over):
			new_chars=false
			for i in range(chars.size()):
				chars[i].position.y = char_offsets[i]
			mousebox.get_child(0).shape.size = Vector3(maxwidth,maxheight,0.01)
			
			mousebox.position.y=-maxheight*char_size*0.5 # center hitbox
			
	else:
		if(mouse_over):
			mouse_hover=min(mouse_hover+0.01,char_size*1.35);
			for i in chars:
				var z =  min(char_size*1.35,mouse_hover+char_size)
				i.scale =Vector3(z,z,z)
		else: 
			mouse_hover= max(mouse_hover-0.01,0)
			for i in chars:
				var z =  min(char_size*1.35,mouse_hover+char_size)
				i.scale =Vector3(z,z,z)
			
			
	
	for i in range(chars.size()):
		chars[i].rotation.z = sin(Time.get_ticks_msec()/628.0 + 0.5*i)/7.0
		
	
	
	pass


func fade():
	fading=true
	get_parent().iter=0
	
func clear_text():
	maxwidth=0
	maxheight=0
	for i in self.get_children():
		if i is Sprite3D:
			i.queue_free()
	chars=[]

func show_text():
	new_chars=true
	char_offsets = []
	for i in range(chars.size()):
		char_offsets.append(chars[i].position.y)  
		
	st_time=Time.get_ticks_msec()

func new_line(text):
	mousebox = get_child(0)
	text = text +"\n"
	maxwidth=0
	maxheight=0
	chars=[]
	#print("newline")
	var newline=0
	var line_len=0
	var lines=0
	line_len = text.find("\n") 

	for i in range(text.length()):
		

		if(line_len<=0):
			line_len=text.length()
		if(text[i]=="\n" or i == text.length()-1):
			line_len = text.find("\n",newline+1) - (newline)
			
			newline = text.find("\n",newline+1)
			lines+=1
			#print(line_len)
			if(maxwidth<line_len*0.5*char_size):
				maxwidth = line_len*0.5*char_size
		
		
		elif(text[i]!=" "):
			var char3d = Sprite3D.new();
			char3d.texture = font #texdict[text[i]]
			char3d.region_enabled=true;
			
			char3d.region_rect= Rect2((text.unicode_at(i)-32)*64, 0,64,64);
			char3d.position.x = (i-newline - 0.5*line_len)   * char_size *0.5 
			char3d.position.y = char_size * 0.6 * -lines;
			char3d.scale= Vector3(0,0,0)
			chars.append(char3d)
			add_child(char3d)
	maxheight = lines*0.6*char_size
	#print("maxwidth: ", maxwidth, " maxheight: ", maxheight)

func load_textures(char):
	var image = Image.load_from_file("res://sprites//text//" + char +".png")
	var texture = ImageTexture.create_from_image(image)
	texdict[char]=texture


func on_look_at():
	mouse_over=true;
	
func on_stop_look_at():
	mouse_over = false;


