extends Control

onready var lifeContainer = $LifeContainer
var LifeIcon = preload("res://HUD/LifeIcon.tscn")
var score = 0
onready var scoreLabel = $Score

func _ready():
	clearLives()
	Signals.connect("on_player_life_changed", self, "_on_player_life_changed")
	Signals.connect("on_score_increment", self, "_on_score_increment")
	
func clearLives():
	for child in lifeContainer.get_children():
		lifeContainer.remove_child(child)
		child.queue_free()

func _on_score_increment(amount):
	score += amount 
	scoreLabel.text = str(score)

func setLives(lives):
	clearLives()
	for i in range(lives):
		lifeContainer.add_child(LifeIcon.instance())

func _on_player_life_changed(life):
	setLives(life)
