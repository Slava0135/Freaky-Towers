extends PanelContainer

class_name PauseMenu

signal continue_game
signal restart_game
signal leave_game

func update_score(score: int):
	$VBox/Score.text = str(score)

func game_over():
	$VBox/ContinueButton.disabled = true
	$VBox/Title.text = "GAME OVER"

func easy_mode():
	$VBox/Score.hide()
	$VBox/ScoreText.hide()

func _on_continue_button_pressed():
	get_tree().paused = false
	continue_game.emit()

func _on_restart_button_pressed():
	get_tree().paused = false
	restart_game.emit()

func _on_main_menu_button_pressed():
	get_tree().paused = false
	leave_game.emit()
