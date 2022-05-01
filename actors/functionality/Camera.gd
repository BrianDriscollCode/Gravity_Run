extends Camera2D
 
export (NodePath) var TargetNodepath = null
var target_node
export (float) var lerpspeed = 0.04
 
func _ready():
		target_node  = get_node(TargetNodepath)
		
func _process(_delta):
 
	self.position = lerp(self.position, target_node.position, lerpspeed)
