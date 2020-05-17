extends Node

func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer/StartButton.grab_focus()

func _physics_process(delta):
	delta = delta
	if $MarginContainer/VBoxContainer/VBoxContainer/StartButton.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer/StartButton.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/ExitButton.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer/ExitButton.grab_focus()


func _on_StartButton_pressed():
	get_tree().change_scene("res://scenes/world.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()
