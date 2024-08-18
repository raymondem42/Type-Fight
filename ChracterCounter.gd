extends Control


@onready var result_label = $Label
@onready var WordCheckFile = "res://words_alpha.txt"
@onready var AnimalCheckFile = "res://animals.txt"
@onready var ElementCheckFile = "res://elements.txt"
@onready var FoodCheckFile = "res://food.txt"
@onready var CountryCheckFile = "res://countries.txt"
@onready var prompt = "res://prompts.txt"


@onready var timer = $Timer
@onready var countdown_label = $CountdownLabel  # A label to display the countdown timer
@onready var text_input =  $LineEdit #user enter words

@onready var timerCheck = true

var is_player1_turn = true
var player1Score = 0
var player2Score = 0

var player1scores = []
var player2scores = []
var promptsInfo = []
var random_index = randi() % 55


func _ready() -> void:
	timer.wait_time = 15.0
	timer.one_shot = false
	timer.start()
	timer.connect("timeout", _on_Timer_timeout)
	
	#reading the prompt file
	var prompt = FileAccess.open((prompt), FileAccess.READ)
	var prompt_content = prompt.get_as_text()
	promptsInfo = prompt_content.split("\n")
	prompt.close()
	
	pick_random_prompt()
	
func pick_random_prompt():
	print(random_index)
	if(random_index < 22):
		if promptsInfo.size() > 0:
				var selected_prompt = promptsInfo[random_index -1]
				print(random_index)
				print("Selected Prompt: ", selected_prompt)
		else:
			print("Selected Prompt: Any word, gogogo")


#seeing if it's a word in general
func check_string_in_file(input_string: String, file_path: String) -> bool:
	input_string = input_string.strip_edges().to_lower()  # Normalize the input	
	var file = FileAccess.open((file_path), FileAccess.READ)
	while not file.eof_reached():
		var line = file.get_line().strip_edges().to_lower()
		if line == input_string:
			file.close()
			return true
	return false


#checking to see if things match
func has_two_of_same_letter(new_text: String) -> bool:
	var letter_counts = {}
	# Count occurrences of each letter
	for letter in new_text:
		if letter in letter_counts:
			letter_counts[letter] += 1
		else:
				letter_counts[letter] = 1
				# Check if any letter appears exactly twice
				for count in letter_counts.values():
					if count == 2:
						return true
	return false


#checking to see if it is a palindrome
func is_palindrome(new_text: String) -> bool:
	var reversed_word = new_text.reverse()
	return new_text == reversed_word

#checking to see if it contains all vowels
func contains_vowels(new_text: String) -> bool:
	var vowels = ["a", "e", "i", "o", "u"]
	var vowel_count  = 0
	
	 # Check for each vowel in the word
	for letter in new_text:
		if letter in vowels:
			vowel_count += 1
		if(vowel_count >= 3):
			return true
	return false
	
	#checking to see if it contains all vowels
func contains_2_vowels(new_text: String) -> bool:
	var vowels = ["a", "e", "i", "o", "u"]
	var vowel_count  = 0
	
	 # Check for each vowel in the word
	for letter in new_text:
		if letter in vowels:
			vowel_count += 1
	return vowel_count == 2

func contains_no_vowels(new_text: String) -> bool:
	var vowels = ["a", "e", "i", "o", "u"]
	var vowel_count  = 0
	
	 # Check for each vowel in the word
	for letter in new_text:
		if letter in vowels:
			vowel_count += 1
	return vowel_count == 0
	
	
#seeing if last letter and first letter are the same
func starts_and_ends_with_same_letter(new_text: String) -> bool:
	if(new_text.length() > 0):
		return new_text[0] == new_text[-1]
	return false

#y in middle of the word
func contains_y_not_at_beginning_or_end(word: String) -> bool:
	if word.length() > 2:  # Ensure the word has more than two characters
		var middle_part = word.substr(1, word.length() - 2)  # Get the middle part of the word
		return "y" in middle_part
	return false
	
#setting word/game logic
func prompt_function(new_text):
	#print("hello world")
	match random_index:
		1:
			if "e" in new_text.to_lower():
				print("that has an E")
				return false
			else:
				print("no E here")
				return true
		2:
			if "a" in new_text.to_lower():
				print("that has an A")
				return false
			else:
				print("no A here")
				return true
		3:
			if new_text.to_lower().begins_with("y"):
				print("begins wtih Y")
				return true
			else:
				print("no y here")
				return false
		4:
			if has_two_of_same_letter(new_text):
				print("There's 2 letters here")
				return true
			else:
				print("no 2 leter")
				return false
		5:
			if is_palindrome(new_text):
				print("yup that's a palindrome")
				return true
			else:
				print("not a palindrome")
				return false
		6:
			if contains_vowels(new_text):
				print("yup that's 3 vowels")
				return true
			else:
				print("not at least 3")
				return false
		7:
			if new_text.to_lower().ends_with("ing"):
				print("yup that's end with ing")
				return true
			else:
				print("no it does not")
				return false
		8:
			if contains_2_vowels(new_text):
				print("yup that has 2")
				return true
			else:
				print("no it does not")
				return false
		9:
			if "j" in new_text.to_lower():
				print("yup that has a J")
				return true
			else:
				print("no it does not")
				return false
		10:
			if new_text.to_lower().begins_with("ch"):
				print("yup that starts with ch")
				return true
			else:
				print("no it does not")
				return false
		11:
			if "th" in new_text.to_lower():
				print("yup that has a th")
				return true
			else:
				print("no it does not")
				return false
		12:
			if contains_no_vowels(new_text):
				print("yup that has none")
				return true
			else:
				print("no it does not")
				return false
		13:
			if new_text.to_lower().ends_with("x"):
				print("yup that ends in x")
				return true
			else:
				print("no it does not")
				return false
		14:
			if starts_and_ends_with_same_letter(new_text):
				print("yup that starts and ends the same")
				return true
			else:
				print("no it does not")
				return false
		15:
			#seeing if Y is in the middle of the word
			if contains_y_not_at_beginning_or_end(new_text):
				print("yup that has y in the middle ")
				return true
			else:
				print("no it does not")
				return false
		16:
			#seeing if Y is in the middle of the word
			if check_string_in_file(new_text, CountryCheckFile):
				print("yup that's a country")
				return true
			else:
				print("no it is does not")
				return false
		17:
			#seeing if Y is in the middle of the word
			if check_string_in_file(new_text, AnimalCheckFile):
				print("yup that's a animal")
				return true
			else:
				print("no it does not")
				return false
		18:
			#seeing if Y is in the middle of the word
			if check_string_in_file(new_text, ElementCheckFile):
				print("yup that's a element")
				return true
			else:
				print("no it does not")
				return false
		19:
			#seeing if Y is in the middle of the word
			if check_string_in_file(new_text, FoodCheckFile):
				print("yup that's a food")
				return true
			else:
				print("no it does not")
				return false
		20:
			#seeing if Y is in the middle of the word
			if check_string_in_file(new_text, AnimalCheckFile) and new_text.to_lower().begins_with("e"):
				print("yup that's an animal that starts with e")
				return true
			else:
				print("no it does not")
				return false
		21:
			#seeing if Y is in the middle of the word
			if check_string_in_file(new_text, AnimalCheckFile) and new_text.to_lower().begins_with("o"):
				print("yup that's an animal that starts with e")
				return true
			else:
				print("no it does not")
				return false
	if(random_index > 21):
		if(check_string_in_file(new_text, WordCheckFile)):
			print("yup that's a real word")
			return true
		else:
			return false


func _on_text_submitted(new_text: String) -> void:		
	if prompt_function(new_text):
		timer.stop()
		var char_count = new_text.length()
		print(char_count)
		if is_player1_turn:
			player1Score += char_count
			player1scores.append(player1Score)
			result_label.text = "Player 1 scored " + str(char_count) + " points."
			result_label.text += "\nPlayer 2's turn next. Press Space to start."
			timer.stop() #will stop timer only if word is valid
			end_turn()
		else:
			player2Score += char_count
			player2scores.append(player2Score)
			result_label.text = "Player 2 scored " + str(char_count) + " points."
			countdown_running = false #stops countdown
			timer.stop()
			announce_round_winner()  # End the round and announce the winner
	else:
		#  input is invalidallow retry
		result_label.text = "Invalid word! Try again"
		text_input.clear() #clears the input for retry
		text_input.grab_focus()
		
func end_turn() -> void:
	
	text_input.clear()
	text_input.editable = false #this will disable inputs
		if(is_player1_turn):
			player1Score = 0
			player1scores.append(player1Score)
		else:
			player2Score = 0
			player2scores.append(player2Score)
			
	is_player1_turn = not is_player1_turn
	round_ready = true #next round is a go
	countdown_running = false #countdonw not running
	timer.stop() 
	
	# The next turn will start when the player press space 
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
	

	#start_new_turn()


func _on_timer_timeout() -> void:
	pass # Replace with function body.
