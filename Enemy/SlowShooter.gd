extends Enemy
class_name SlowShooter

export var fireRate = 1 
onready var fireTimer = $FireTimer

func _process(delta):
	if fireTimer.is_stopped():
		fire()
		fireTimer.start(fireRate)
