extends Node

var score = 0
@onready var score_label = get_node("/root/Game/Hud/CoinLabel")
@onready var transition_timer = Timer.new()

const VICTORY_COIN_THRESHOLD = 9 # set to 1 for testing

func _ready():
	add_child(transition_timer)
	transition_timer.one_shot = true
	transition_timer.wait_time = 0.5  # delay before switching scene
	transition_timer.connect("timeout", Callable(self, "_on_transition_timer_timeout"))

func add_point():
	score += 1
	score_label.text = "Coins: " + str(score)

	if score >= VICTORY_COIN_THRESHOLD:
		transition_timer.start()

func _on_transition_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
