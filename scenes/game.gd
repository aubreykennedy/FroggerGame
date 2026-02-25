extends Node2D

# store the car scene inside of the game scene
var car_scene: PackedScene = preload("res://scenes/car.tscn")
var score: int

func _on_finish_area_2d_body_entered(_body: Node2D) -> void:
	# ensure Godot does not get stuck on a physics scene while changing scenes
	call_deferred("change_scene")
	if score < Global.score:
		Global.score = score

# this is the scene change referenced above
func change_scene():
	# to change scene call deferred and call another func so that you call another func 
	# making sure physics objects don't cause problems
	get_tree().change_scene_to_file("res://scenes/title.tscn")

func _on_car_timer_timeout() -> void:
	# create an instance of the car scene
	var car = car_scene.instantiate() as Area2D
	# to actually see the car, attach the car to the current scene
	var pos_marker = $CarStartPositions.get_children().pick_random() as Marker2D
	car.position = pos_marker.position 
	$Objects.add_child(car)
	
	# once a car has spawned we can **connect a signal** via gd script
	# run car instance NOT scene
	# get node/scene want to connect, call connect with signal name and then the fuction you want to call
	# always make sure you're accounting for the all arg Godot is passing into the function
	car.connect("body_entered", go_to_title)

func go_to_title(_body):
	# print(body)
	# note static bodies are still bodies! e.g. the border!
	# print('player car collision')	
	call_deferred("change_scene")

func _on_score_timer_timeout() -> void:
	score += 1
	$CanvasLayer/Label.text = str(score)
	# $CanvasLayer/Label.text = 'Time elapsed: ' + str(score)
