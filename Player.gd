extends Area2D

signal hit
signal eat

const SPEED = 420
var screen_size


func _ready():
	screen_size = get_viewport_rect().size
	hide()


func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x > 0:
		$AnimatedSprite.flip_h = true
	if velocity.x < 0:
		$AnimatedSprite.flip_h = false


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_Player_body_entered(body):
	if body.has_method("bad"):
		hide()
		emit_signal("hit")
		$CollisionShape2D.set_deferred("disabled", true)
	else:
		emit_signal("eat")
		body.queue_free()
