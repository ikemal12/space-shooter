extends Area2D
class_name Powerup

export var powerupMoveSpeed = 50

func _physics_process(delta):
	position.y += powerupMoveSpeed * delta
	
func applyPowerup(player: Player):
	# this needs to be implemented by the inherited class
	pass

func _on_Powerup_area_entered(area):
	if area is Player:
		applyPowerup(area)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
