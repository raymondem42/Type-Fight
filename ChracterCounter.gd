extends Control

#label to tell back to the character
@onready var result_label = $Label
@onready var WordCheckFile = "res://words_alpha.txt"
@onready var AnimalCheckFile = "res://animals.txt"
@onready var ElementCheckFile = "res://elements.txt"
@onready var FoodCheckFile = "res://food.txt"
@onready var CountryCheckFile = "res://countires.txt"
@onready var prompt = "res://prompts.txt"


@onready var timer = $Timer
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
	if promptsInfo.size() > 0:

		var selected_prompt = promptsInfo[random_index]
		print(random_index)
		print("Selected Prompt: ", selected_prompt)
		


#seeing if it's a word in general
func check_string_in_file(input_string: String, file_path: String) -> bool:
	var file = FileAccess.open((WordCheckFile), FileAccess.READ)
	var file_content = file.get_as_text()
	file.close()
	if input_string in file_content:
		return true
	else:
		print("word does not exist")
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
		2:
			print("we at 2")
			if "a" in new_text.to_lower():
				print("that has an A")
		3:
			if new_text.to_lower().begins_with("y"):
				print("begins wtih Y")
			else:
				print("no y here")
		4:
			if has_two_of_same_letter(new_text):
				print("nah there's 2 letters here")
		5:
			if is_palindrome(new_text):
				print("yup that's a palindrome")
			else:
				print("not a palindrome")
		6:
			if contains_vowels(new_text):
				print("yup that's 3 vowels")
			else:
				print("not at least 3")
		7:
			if new_text.to_lower().ends_with("ing"):
				print("yup that's end with ing")
			else:
				print("no it does not")
		8:
			if contains_2_vowels(new_text):
				print("yup that has 2")
			else:
				print("no it does not")
		9:
			if "j" in new_text.to_lower():
				print("yup that has a J")
			else:
				print("no it does not")
		10:
			if new_text.to_lower().begins_with("ch"):
				print("yup that starts with ch")
			else:
				print("no it does not")
		11:
			if "th" in new_text.to_lower():
				print("yup that has a th")
			else:
				print("no it does not")
		12:
			if contains_no_vowels(new_text):
				print("yup that has none")
			else:
				print("no it does not")
		13:
			if new_text.to_lower().ends_with("x"):
				print("yup that ends in x")
			else:
				print("no it does not")
		14:
			if starts_and_ends_with_same_letter(new_text):
				print("yup that starts and ends the same")
			else:
				print("no it does not")
		15:
			#seeing if Y is in the middle of the word
			if contains_y_not_at_beginning_or_end(new_text):
				print("yup that has y in the middle ")
			else:
				print("no it does not")
		16:
			#seeing if Y is in the middle of the word
			if check_string_in_file(new_text, CountryCheckFile):
				print("yup that's a country")
			else:
				print("no it does not")
		17:
			#seeing if Y is in the middle of the word
			if check_string_in_file(new_text, AnimalCheckFile):
				print("yup that's a animal")
			else:
				print("no it does not")
		18:
			#seeing if Y is in the middle of the word
			if check_string_in_file(new_text, ElementCheckFile):
				print("yup that's a element")
			else:
				print("no it does not")
		19:
			#seeing if Y is in the middle of the word
			if check_string_in_file(new_text, FoodCheckFile):
				print("yup that's a food")
			else:
				print("no it does not")
		20:
			#seeing if Y is in the middle of the word
			if check_string_in_file(new_text, AnimalCheckFile) and new_text.to_lower().begins_with("e"):
				print("yup that's an animal that starts with e")
			else:
				print("no it does not")
		21:
			#seeing if Y is in the middle of the word
			if check_string_in_file(new_text, AnimalCheckFile) and new_text.to_lower().begins_with("o"):
				print("yup that's an animal that starts with e")
			else:
				print("no it does not")
	if(random_index > 21):
		check_string_in_file(new_text, WordCheckFile)


func _on_text_submitted(new_text: String) -> void:		
	if prompt_function(new_text):
		timer.stop()
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
