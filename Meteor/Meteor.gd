extends Area2D

export var minSpeed = 10
export var maxSpeed = 20
var speed = 0
var rotationRate = 0 
export var minRotationRate = -20
export var maxRotationRate = 20
export var life = 20
var playerInArea: Player = null
var MeteorEffect = preload("res://Meteor/MeteorEffect.tscn")

func _ready():
	speed = rand_range(minSpeed, maxSpeed)
	rotationRate = rand_range(minRotationRate, maxRotationRate)

func _process(delta):
	if playerInArea != null:
		playerInArea.damage(1)

func _physics_process(delta):
	rotation_degrees += rotationRate * delta
	position.y += speed * delta
	
func damage(amount):
	if life <= 0:
		return
	
	life -= amount 
	if life <= 0:
		var effect = MeteorEffect.instance()
		effect.position = position
		get_parent().add_child(effect)
		
		Signals.emit_signal("on_score_increment", 2)
		
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Meteor_area_entered(area):
	if area is Player:
		area.damage(1)
		playerInArea = area

func _on_Meteor_area_exited(area):
	if area is Player:
		playerInArea = null 
