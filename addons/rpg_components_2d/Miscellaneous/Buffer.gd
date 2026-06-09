extends Node
## A buffer which stays [code]true[/code] for a specified time duration before turning [code]false[/code].[br][br]
## This is really useful for temporarily storing an attack state, which will allow combo moves!!
class_name Buffer

## Emitted whenever the buffer ends/finishes.
signal end()

## How long the buffer lasts.
@export var duration : float = 0.5
## The boolean which tells if the buffer is currently active or not.
var buffer : bool = false
## Time duration left before the ends.
var timer : float = 0

func _process(delta: float) -> void:
	if timer > 0 : timer -= delta
	if timer < 0 :
		buffer = false
		emit_signal("end")

## Activates the buffer.
func start():
	buffer = true
	timer = duration
