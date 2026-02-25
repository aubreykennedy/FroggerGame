extends Area2D

var direction = Vector2.LEFT
var speed = 100
var colors = [
	preload("res://graphics/cars/red.png"),
	preload("res://graphics/cars/green.png"),
	preload("res://graphics/cars/yellow.png"),
	]

# Called when the node enters the scene tree for the first time.
# ! ALWAYS REMEMBER: ready is called when called whyen you're adding the node to the scene tree
func _ready() -> void:
	# turns left vector to right so cars can move right to left
	if position.x < 0:
		direction.x = 1
		# print('car direction')
		# get the Sprite2D and make sure cars are facing the right direction
		$Sprite2D.flip_h = true
		$Sprite2D.texture = colors.pick_random()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# destroy the current instance of the node so cars no longer on screen are removed
	queue_free()
