extends Control

#label to tell back to the character
@onready var result_label = $Label
@onready var WordCheckFile = "res://words_alpha.txt"
@onready var File
var is_player1_turn = true
var player1Score = 0
var player2Score = 0

var player1scores = []
var player2scores = []



# Function to check if a word is in the text file
func is_word_in_file(word: String) -> bool:
	var file = File.new()
	if file.file_exists(WordCheckFile):
		file.open(WordCheckFile, File.READ)
		# Read the entire file as text
		var file_content = file.get_as_text()
		# Convert to lowercase for case-insensitive search
		file_content = file_content.to_lower()
		word = word.to_lower()
		file.close()
		# Check if the word exists in the file
		return word in file_content
	else:
		print("File not found!")
		return false


func _on_text_submitted(new_text: String) -> void:
	# Count the characters in the entered text4
	var char_count = new_text.length()
	if is_player1_turn:
		player1Score += char_count
		result_label.text = "Player 1 Score: " + str(player1Score)
		player1scores.append(player1Score)
	else:
		player2Score += char_count
		result_label.text = "Player 2 Score: " + str(player2Score)
		player2scores.append(player2Score)
		player1Score = 0
		player2Score = 0
	is_player1_turn = not is_player1_turn
