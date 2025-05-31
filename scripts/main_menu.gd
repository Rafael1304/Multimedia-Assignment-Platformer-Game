extends Control

@onready var sound_settings = $SoundSettings
@onready var delay_timer := Timer.new()
var action_to_run := ""

func _ready():
	add_child(delay_timer)
	delay_timer.wait_time = 0.2
	delay_timer.one_shot = true
	delay_timer.connect("timeout", Callable(self, "_on_delay_timer_timeout"))

func _on_start_pressed() -> void:
	action_to_run = "start"
	delay_timer.start()

func _on_exit_pressed() -> void:
	action_to_run = "exit"
	delay_timer.start()

func _on_sound_pressed() -> void:
	sound_settings.visible = true

func _on_delay_timer_timeout():
	match action_to_run:
		"start":
			get_tree().change_scene_to_file("res://Scenes/game.tscn")
		"exit":
			get_tree().quit()
