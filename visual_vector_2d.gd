extends Line2D

@export var vehicle_node : Node2D
@export var vector_to_draw : String
@export var vec_scale : float = 0.1
@export var vec_width : int = 2
@export var vec_color : Color

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_point(Vector2(0, 0))
	
	var properties = vehicle_node.get_property_list()
	var found = false
	for property in properties:
		if property.name == vector_to_draw:
			found = true
			break
	
	assert(found)
	
	self.add_point(vehicle_node.get(vector_to_draw).rotated(vehicle_node.rotation * -1) * vec_scale)
	self.set_width(vec_width)
	self.set_modulate(vec_color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.set_point_position(1, vehicle_node.get(vector_to_draw).rotated(vehicle_node.rotation * -1) * vec_scale)
