extends Control


@onready var result_label = $Label
@onready var WordCheckFile = "res://words_alpha.txt"
@onready var timer = $Timer
@onready var countdown_label = $CountdownLabel  # A label to display the countdown timer
@onready var text_input =  $LineEdit #user enter words


var is_player1_turn = true
var player1Score = 0
var player2Score = 0

var player1scores = []
var player2scores = []

var current_round = 1 
var total_rounds = 4  #max rounds


var countdown_running = false  #control countdown status
var round_ready = false        #when round is ready to start

func _ready() -> void:
	timer.connect("timeout", Callable (self, "_on_Timer_timeout"))
	
	timer.wait_time = 15.0  #change timer time
	timer.one_shot = true
	show_ready_message() #show ready message to player
	
	text_input.connect("text_submitted", Callable(self, "_on_text_submitted")) #will take care of user inputs

func check_string_in_file(input_string: String, _file_path: String) -> bool:
	input_string = input_string.strip_edges().to_lower()  # Normalize the input
	var file = FileAccess.open(WordCheckFile, FileAccess.READ)
	if file:
		var file_content = file.get_as_text()
		file.close()
		# Split the file content by lines and check if the input string is in the list of words
		var word_list = file_content.split("\n")
		return input_string in word_list
	
	return false



func _on_LineEdit_text_submitted(new_text: String) -> void:
	if timer.is_stopped():
		return  # Ignore input if the timer has ended
		
	timer.stop() #stops becaouse player enterd something
	countdown_running = false #stops countdown
	
	text_input.clear() #clears teh users input for next user
	text_input.editable = false # disables editing until the next round starts 
	

	if check_string_in_file(new_text, WordCheckFile):
		var char_count = new_text.length()
		if is_player1_turn:
			player1Score += char_count
			player1scores.append(player1Score)
			result_label.text = "Player 1 scored " + str(char_count) + " points."
			result_label.text += "\nPlayer 2's turn next. Press Space to start."
			
		else:
			player2Score += char_count
			player2scores.append(player2Score)
			result_label.text = "Player 2 scored " + str(char_count) + " points."
			announce_round_winner()  # End the round and announce the winner
	else:
		#  input is invalid
		result_label.text = "Invalid word!"
		
	is_player1_turn = not is_player1_turn
	round_ready = true #next round is a go
	
	# The next turn will start when the player press space 
	
func start_new_turn() -> void:
	if current_round > total_rounds:
		announce_final_winner()
		return
	result_label.text = "Round " + str(current_round) + ": "  # Display the current round number
	
	if is_player1_turn:
		result_label.text = "Player 1's turn. Go!"
	else:
		result_label.text = "Player 2's turn. Go!"
	
	text_input.editable = true #lets player enter guess
	text_input.grab_focus() #n
	
	# starts the countdown
	countdown_running = true  #set to true when starts
	round_ready = false # change to not ready
	timer.start()
	_countdown_timer(15)  # change countdown time
	
func show_ready_message() -> void:
	result_label.text = "Round " + str(current_round) + " is about to start. Press SPACE to begin." 
	round_ready = true  # Change it back to ready to start
	text_input.editable = false  # Disable the text input until the round starts  

func _countdown_timer(time_left: int) -> void:
	# Display countdown timer
	if countdown_running and time_left > 0:
		countdown_label.text = str(time_left)
		await get_tree().create_timer(1.0).timeout
		if countdown_running: 
			_countdown_timer(time_left - 1)
	else:
		countdown_label.text = ""  # Clear the countdown label when the timer ends

func _on_timer_timeout() -> void:
	countdown_running = false #stop countdown
	if is_player1_turn:
			player1Score = 0
			player1scores.append(player1Score)
			result_label.text = "Time's up! Player 1's score: " + str(player1Score)
	else:
		player2Score = 0
		player2scores.append(player2Score)
		result_label.text = "Time's up! Player 2's score: " + str(player2Score)
	
	result_label.text += "\nRound over! Next player's turn. Press Space to start."
	print("Round is done.")
	
	# manually start the next round
	is_player1_turn = not is_player1_turn
	round_ready = true #change to show next round is ready to start
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_SPACE:
		if round_ready:
			start_new_turn()
			
func announce_round_winner() -> void:
	#announce winner of round with pts for both
	result_label.text = "Round " + str(current_round) + " results:\n"
	result_label.text += "Player 1: " + str(player1Score) + " points\n"
	result_label.text += "Player 2: " + str(player2Score) + " points\n"
	
	
	# Announce the winner of the round
	if player1Score > player2Score:
		result_label.text += "\nPlayer 1 wins this round!"
	elif player2Score > player1Score:
		result_label.text += "\nPlayer 2 wins this round!"
	else:
		result_label.text += "\nThis round is a tie!"
	
	# Prepare for the next round or end the game
	current_round += 1
	if current_round > total_rounds:
		announce_final_winner()
	else:
		if current_round == total_rounds:
			result_label.text += "\nPress Space to start the Final Round!"
		else:
			result_label.text += "\nPress Space to start Round " + str(current_round) + "."
		round_ready = true  # Set to true so the player can start the next round
		
func announce_final_winner() -> void:
	# Calculate the total points for each player
	var player1_total_points = player1Score
	var player2_total_points = player2Score
	
	# Announce the overall winner after the last round
	result_label.text = "Final results:\n"
	result_label.text += "Player 1: " + str(player1_total_points) + " points\n"
	result_label.text += "Player 2: " + str(player2_total_points) + " points\n"
	
	if player1_total_points > player2_total_points:
		result_label.text += "Player 1 WINS!"
	elif player2_total_points > player1_total_points:
		result_label.text += "Player 2 WINS!" 
	else:
		result_label.text += "The game is a tie with both players scoring " + str(player1_total_points) + " points!"

	# Optionally, reset the game or exit

func reset_scores() -> void:
	# Reset scores for the next round
	player1Score = 0
	player2Score = 0
