extends Control


func _ready():
	$MarginContainer/VBoxContainer/StartButton.grab_focus()


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
