extends Control

func _ready() -> void:
	$HighScore.text = "High score: " + str(Global.score)

# return to game!
func _process(_delta: float) -> void: 
	if Input.is_action_just_pressed("confirm"):
		get_tree().change_scene_to_file("res://scenes/game.tscn")
	
