extends Area2D
class_name Enemy

export var verticalSpeed = 10
export var health = 5
var playerInArea: Player = null
onready var firingPositions = $FiringPositions
var Bullet = preload("res://Bullet/EnemyBullet.tscn")
var EnemyExplosion = preload("res://Enemy/EnemyExplosion.tscn")

func _process(delta):
	if playerInArea != null:
		playerInArea.damage(1)

func _physics_process(delta):
	position.y += verticalSpeed * delta
	
func fire():
	for child in firingPositions.get_children():
		var bullet = Bullet.instance()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = child.global_position
	
func damage(amount):
	if health <= 0:
		return
	
	health -= amount
	if health <= 0:
		var effect = EnemyExplosion.instance()
		effect.global_position = global_position
		get_tree().current_scene.add_child(effect)
		
		Signals.emit_signal("on_score_increment", 1)
		
		queue_free()
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Enemy_area_entered(area):
	if area is Player:
		playerInArea = area

func _on_Enemy_area_exited(area):
	if area is Player:
		playerInArea = null
