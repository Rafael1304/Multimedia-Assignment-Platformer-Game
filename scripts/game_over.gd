extends Control

@onready var delay_timer := Timer.new()
var action_to_run := ""

func _ready() -> void:
	add_child(delay_timer)
	delay_timer.wait_time = 0.5
	delay_timer.one_shot = true
	delay_timer.connect("timeout", Callable(self, "_on_delay_timer_timeout"))

func _on_main_menu_pressed() -> void:
	action_to_run = "menu"
	delay_timer.start()

func _on_exit_pressed() -> void:
	action_to_run = "exit"
	delay_timer.start()

func _on_delay_timer_timeout():
	match action_to_run:
		"menu":
			get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
		"exit":
			get_tree().quit()
