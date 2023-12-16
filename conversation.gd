extends Node3D


# Called when the node enters the scene tree for the first time.
var textbox

var lines=["PSST... I'M A LAMP.\nDON'T TELL ANYBODY!", "...","MAYBE I SHOULDN'T'VE\nSAID THAT."]
var convtree={"PSST... I'M A LAMP\nDON'T TELL ANYBODY!":["HUH?", "I'M GONNA TELL PEOPLE"], 
				"HUH?":["I'M THE FIRST LAMP\nTO EVER COMPETE!"], 
				"I'M GONNA TELL PEOPLE":["PLEASE DON'T."],
				"I'M THE FIRST LAMP\nTO EVER COMPETE!":["I'M NOT SURE IF\nIT'S AGAINST\nTHE RULES,"], "PLEASE DON'T.":[], 
				"I'M NOT SURE IF\nIT'S AGAINST\nTHE RULES,": ["BUT I DON'T\nWANT TO ASK."],
				"BUT I DON'T\nWANT TO ASK.":["I WON'T TELL ANYBODY","WHATEVER."],
				"I WON'T TELL ANYBODY":["THANKS"],
				"THANKS":[],
				"WHATEVER.":[""],
				"":[]
				}

var current_conv

var options=[]

var linear=false;
var iter;
func _ready():
	iter=0
	options=[get_node("option 1"), get_node("option 2"), get_node("option 3")]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func trigger_conversation(conv):
	current_conv=conv
	if(linear):
		textbox = self.find_child("textbox")
		textbox.new_line("PSST... I'M A LAMP.\nDON'T TELL ANYBODY!");
		textbox.show_text()
	else:
		textbox = self.find_child("textbox")
		textbox.new_line(current_conv);
		textbox.show_text()
		for i in range(convtree[current_conv].size()):
			options[i].new_line(convtree[current_conv][i])
			textbox.show_text()

func leave_conversation():
	textbox.fade()
	for i in options:
		i.fade()
	

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_E:
			if(linear and get_node("textbox").mouse_over):
				textbox.clear_text()
				iter+=1
				if(iter>=lines.size()):
					textbox.clear_text()
					iter=-1;
					
				else:
					textbox.new_line(lines[iter]);
				textbox.show_text()
			if(!linear):
				if(current_conv!=null and convtree[current_conv].size()==1):
					if(textbox.mouse_over):
						current_conv = convtree[current_conv][0]
						
						textbox.clear_text()
						textbox.new_line(current_conv)
						textbox.show_text()
							
						for j in range(3):
							options[j].clear_text()
							if(1<convtree[current_conv].size() and j<convtree[current_conv].size()):
								options[j].new_line(convtree[current_conv][j])
								options[j].show_text()
				elif(current_conv!=null ):
					for i in range(3):
						var option = options[i]
						
						if(option.mouse_over and i<convtree[current_conv].size()):
							current_conv=convtree[convtree[current_conv][i]][0]
							
							textbox.clear_text()
							textbox.new_line(current_conv)
							textbox.show_text()
								
							for j in range(3):
								options[j].clear_text()
								if(1<convtree[current_conv].size() and j<convtree[current_conv].size()):
									options[j].new_line(convtree[current_conv][j])
									options[j].show_text()
