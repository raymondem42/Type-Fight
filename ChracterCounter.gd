extends Control


@onready var result_label = $Label
@onready var WordCheckFile = "res://words_alpha.txt"
@onready var timer = $Timer
@onready var countdown_label = $CountdownLabel  # A label to display the countdown timer

var is_player1_turn = true
var player1Score = 0
var player2Score = 0

var player1scores = []
var player2scores = []

var countdown_running = false  

func _ready() -> void:
	timer.connect("timeout", Callable (self, "_on_Timer_timeout"))
	
	timer.wait_time = 15.0
	timer.one_shot = true
	start_new_turn()

func check_string_in_file(input_string: String, file_path: String) -> bool:
	var file = FileAccess.open(WordCheckFile, FileAccess.READ)
	var file_content = file.get_as_text()
	file.close()
	return input_string in file_content

func _on_text_submitted(new_text: String) -> void:
	if timer.is_stopped():
		return  # Ignore input if the timer has ended
		
	timer.stop() #stops becaouse player enterd something
	countdown_running = false #stops countdown
	if check_string_in_file(new_text, WordCheckFile):
		var char_count = new_text.length()
		if is_player1_turn:
			player1Score += char_count
			player1scores.append(player1Score)
			result_label.text = "Player 1 Score: " + str(player1Score)
			
		else:
			player2Score += char_count
			player2scores.append(player2Score)
			result_label.text = "Player 2 Score: " + str(player2Score)
			
	else:
		#  input is invalid
		result_label.text = "Invalid word!"

# The round is done. update the player's score and wait for the next player's turn
	if is_player1_turn:
		result_label.text += "\nRound over! Player 2's turn next. Press Space to start"
	else:
		result_label.text += "\nRound over! Player 1's turn next.Press Space to start"
		
	is_player1_turn = not is_player1_turn
	
	# The next turn will start when the player press space 
	
func start_new_turn() -> void:
	if is_player1_turn:
		result_label.text = "Player 1's turn. Get ready!"
	else:
		result_label.text = "Player 2's turn. Get ready!"
	
	# starts the countdown
	countdown_running = true  #set to true when starts
	timer.start()
	_countdown_timer(15)  # Start countdown 

func _countdown_timer(time_left: int) -> void:
	# Display countdown timer
	if time_left > 0:
		countdown_label.text = str(time_left)
		await get_tree().create_timer(1.0).timeout
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
	
	result_label.text += "\nRound over! Next player's turn."
	print("Round is done.")
	
	# Stop the timer and wait for the player to manually start the next round
	is_player1_turn = not is_player1_turn
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_SPACE:
		if not countdown_running:
			start_new_turn()
