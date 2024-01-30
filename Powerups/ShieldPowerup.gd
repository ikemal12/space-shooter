extends Powerup

export var shieldTime = 6

func applyPowerup(player: Player):
	player.applyShield(shieldTime)


