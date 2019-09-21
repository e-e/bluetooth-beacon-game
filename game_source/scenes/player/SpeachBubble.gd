extends Node2D

const CHAR_SPEECH_TIME = 0.1

signal current_text_finished

var speaking = false
var str_length = 0

func _ready():
	$SpeechBubble.visible_characters = 0
	$SpeechBubble/Timer.set_wait_time(CHAR_SPEECH_TIME)
	$AudioStreamPlayer2D.set_stream(preload("res://audio/effects/low_beep.wav"))
	pass

func _on_Timer_timeout():
	if speaking == true:
		$SpeechBubble.visible_characters += 1

func say_text(text, final_delay):
	str_length = str(text).length()
	speaking = true
	show_text(true)
	$AudioStreamPlayer2D.play(0)
	$SpeechBubble.text = text
	$SpeechBubble.visible_characters = 0
	wait(str_length, final_delay)

func wait(char_count, final_delay):
	var delay_time = char_count * float(CHAR_SPEECH_TIME) + final_delay * 1.0
	$SpeechBubble/WaitTimer.set_wait_time(delay_time)
	$SpeechBubble/WaitTimer.set_one_shot(true)
	$SpeechBubble/WaitTimer.start()
	
func show_text(value):
	$SpeechBubble.visible = value

func _on_WaitTimer_timeout():
	speaking = false
	
func set_pitch_high(value):
	if value:
		$AudioStreamPlayer2D.set_stream(preload("res://audio/effects/high_beep.wav"))
	else:
		$AudioStreamPlayer2D.set_stream(preload("res://audio/effects/low_beep.wav"))