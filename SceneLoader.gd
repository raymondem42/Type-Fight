extends Control

# Declare variables for the buttons
@onready var singleplayer_button = $VBoxContainer/SinglePlayer
@onready var multiplayer_button = $VBoxContainer/Versus
@onready var exit_button = $VBoxContainer/Exit

func _ready():
	# Connect button signals
	singleplayer_button.pressed.connect(_on_singleplayer_pressed)
	multiplayer_button.pressed.connect(_on_multiplayer_pressed)
	exit_button.pressed.connect(_on_exit_pressed)


func _on_singleplayer_pressed():
	# Load and change to WordInput scene
	var word_input_scene = preload("res://SingleplayerEasy.tscn")
	get_tree().change_scene_to_packed(word_input_scene)

func _on_multiplayer_pressed():
	# Load and change to WordInput scene
	var word_input_scene = preload("res://batlleField.tscn")
	get_tree().change_scene_to_packed(word_input_scene)

func _on_exit_pressed():
	# Quit the application
	get_tree().quit()
