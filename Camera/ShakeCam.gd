extends Camera2D

var shakeAmount = 0
export var shakeBaseAmount = 1
export var shakeDampening = 0.075

func shake(magnitude):
	shakeAmount += magnitude
	
func _process(delta):
	if shakeAmount > 0:
		position.x = rand_range(-shakeBaseAmount, shakeBaseAmount) * shakeAmount
		position.y = rand_range(-shakeBaseAmount, shakeBaseAmount) * shakeAmount
		shakeAmount = lerp(shakeAmount, 0.0, shakeDampening)
	else:
		position = Vector2(0,0)
