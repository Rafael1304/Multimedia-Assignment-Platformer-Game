extends Control

@onready var music_slider = $MusicVolumeSlider
@onready var sfx_slider = $SFXVolumeSlider

func _ready():
	# Initialize sliders to match current volumes
	music_slider.value = linear_to_db(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	sfx_slider.value = linear_to_db(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))

func _on_MusicVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)

func _on_SFXVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
