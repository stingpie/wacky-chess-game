extends Node3D


var time=0

var colors
var bar 
var line
var paper
var frame=0 
var confidence = 50
var smooth_confidence=confidence

# Called when the node enters the scene tree for the first time.
func _ready():
	colors = get_node("colors")
	bar = get_node("bar")
	line = get_node("line")
	paper = get_node("paper")
	
	colors.region_enabled = true;
	bar.vframes=3
	line.vframes=3
	paper.vframes=3
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	smooth_confidence+=delta*(confidence -smooth_confidence)*3
	
	colors.region_rect = Rect2(0,256*frame, smooth_confidence*10.24, 256)
	colors.position.x= (100-smooth_confidence)*10.24*0.0013 / 2
	line.position.x = (50-smooth_confidence)*10.24*0.0013
	time+=delta
	if time>0.5:
		time=0;
		
		bar.frame=(bar.frame+1)%3
		line.frame=(line.frame+1)%3
		paper.frame=(paper.frame+1)%3
		frame=(frame+1)%3
	pass

func subtract_confidence(num):
	confidence=max(confidence-num,0)
	
func add_confidence(num):
	confidence=min(confidence+num, 100)
