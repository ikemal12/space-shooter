extends Area2D

export var speed = 500
var BulletEffect = preload("res://Bullet/EnemyBulletEffect.tscn")

func _physics_process(delta):
	position.y += speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_area_entered(area):
	if area is Player:
		var bulletEffect = BulletEffect.instance()
		bulletEffect.position = position
		get_parent().add_child(bulletEffect)
		
		area.damage(1)
		queue_free() 
