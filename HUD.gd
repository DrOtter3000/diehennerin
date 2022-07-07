extends CanvasLayer


signal start_game


func _ready():
	pass


func show_message(text):
	$LblMessage.text = text
	$LblMessage.show()
	$TimerMessage.start()


func show_game_over():
	show_message("Oopsie Woopsie")
	yield($TimerMessage, "timeout")
	
	$LblMessage.text = "Wer ist die Hennerin?"
	$LblMessage.show()
	
	yield(get_tree().create_timer(1), "timeout")
	$BtnStart.show()


func update_score(score):
	$LblScore.text = str(score)


func _on_BtnStart_pressed():
	$BtnStart.hide()
	emit_signal("start_game")


func _on_TimerMessage_timeout():
	$LblMessage.hide()
