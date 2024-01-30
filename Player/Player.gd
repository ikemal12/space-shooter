extends Area2D
class_name Player 

export var speed = 100
var vel = Vector2(0,0)
onready var animatedSprite = $AnimatedSprite
var Bullet = preload("res://Bullet/Bullet.tscn")
onready var firingPositions = $FiringPositions
export var normalFireDelay = 0.12
export var rapidFireDelay = 0.08
var fireDelay = normalFireDelay
onready var fireDelayTimer = $FireDelayTimer
export var life = 3 
onready var invincibilityTimer = $InvincibilityTimer
export var damageInvincibilityTime = 2
onready var shieldSprite = $Shield
onready var rapidFireTimer = $RapidFireTimer

func _ready():
	shieldSprite.visible = false
	Signals.emit_signal("on_player_life_changed", life)

func _process(delta):
	# animate
	if vel.x < 0: 
		animatedSprite.play("Left")
	elif vel.x > 0:
		animatedSprite.play("Right")
	else: 
		animatedSprite.play("Straight")
	
	# shooting
	if Input.is_action_pressed("shoot") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		
		for child in firingPositions.get_children():
			var bullet = Bullet.instance()
			get_tree().current_scene.add_child(bullet)
			bullet.global_position = child.global_position

func _physics_process(delta):
	var dirVec = Vector2(0,0)
	
	if Input.is_action_pressed("move_left"):
		dirVec.x = -1
	elif Input.is_action_pressed("move_right"):
		dirVec.x = 1
	if Input.is_action_pressed("move_up"):
		dirVec.y = -1
	elif Input.is_action_pressed("move_down"):
		dirVec.y = 1
		
	vel = dirVec.normalized() * speed
	position += vel * delta
	
	# make sure we are within the screen
	var viewRect = get_viewport_rect()
	position.x = clamp(position.x, 0, viewRect.size.x)
	position.y = clamp(position.y, 0, viewRect.size.y)

func damage(amount):
	if !invincibilityTimer.is_stopped():
		return
	
	applyShield(damageInvincibilityTime)
	
	life -= amount 
	Signals.emit_signal("on_player_life_changed", life)
	
	var cam = get_tree().current_scene.find_node("Cam", true, false)
	cam.shake(20)
	
	if life <= 0:
		queue_free()

func applyShield(time):
	invincibilityTimer.start(time + invincibilityTimer.time_left)
	shieldSprite.visible = true
	
func applyRapidFire(time):
	fireDelay = rapidFireDelay
	rapidFireTimer.start(time + rapidFireTimer.time_left)

func _on_InvincibilityTimer_timeout():
	shieldSprite.visible = false

func _on_RapidFireTimer_timeout():
	fireDelay = normalFireDelay
