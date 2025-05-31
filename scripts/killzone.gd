extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()  # Triggers animation + fall in player.gd

	Engine.time_scale = 0.35# Slow-mo effect
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
