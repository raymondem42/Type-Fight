extends Control

#label to tell back to the character
@onready var result_label = $Label
@onready var WordCheckFile = "res://words_alpha.txt"
@onready var timer = $Timer
@onready var timerCheck = true

var is_player1_turn = true
var player1Score = 0
var player2Score = 0

var player1scores = []
var player2scores = []


func _ready() -> void:
	timer.wait_time = 5.0
	timer.one_shot = false
	timer.start()
	timer.connect("timeout", _on_Timer_timeout)
	

func check_string_in_file(input_string: String, file_path: String) -> bool:
	var file = FileAccess.open((WordCheckFile), FileAccess.READ)
	var file_content = file.get_as_text()
	file.close()
	if input_string in file_content:
		return true
	else:
		print("word does not exist")
	return false


func _on_text_submitted(new_text: String) -> void:
	timer.stop()
	if check_string_in_file(new_text, WordCheckFile):
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
	else:
		if(is_player1_turn):
			player1Score = 0
			player1scores.append(player1Score)
		else:
			player2Score = 0
			player2scores.append(player2Score)
			
	is_player1_turn = not is_player1_turn
	#start_new_turn()
	print(player1scores)
	print(player2scores)
	
	
#func start_new_turn() -> void:
#	timer.start()  # Start the timer for the next player's turn
	#print(player1scores)
	#print(player2scores)
#	result_label.text = "It's " + (if is_player1_turn then "Player 1" else "Player 2") + "'s turn!"

func _on_Timer_timeout():
	print("you're out of time")
	timer.stop()
	# This function is called when the timer runs out
	if is_player1_turn:
		player1Score = 0
		player1scores.append(player1Score)
	else:
		player2Score = 0
		player2scores.append(player2Score)
	is_player1_turn = not is_player1_turn
	

	#start_new_turn()


func _on_timer_timeout() -> void:
	pass # Replace with function body.
