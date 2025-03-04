class_name Player
extends CharacterBody2D

@export var move_speed : float = 160.0 

var enemy_in_atack_range = false
var enemy_atack_cooldwon = true
var health = 100
var player_alive  = true






func _physics_process(delta: float) -> void:
	var direction := Vector2.ZERO
	enemy_atack()
	
	
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	velocity = direction.normalized() * move_speed  
	move_and_slide()
	
	
	
	

	if direction.x > 0:
		$AnimatedSprite2D.play("walk_right")
	if direction.x < 0:
		$AnimatedSprite2D.play("walk_left")
	if direction.x == 0:
		$AnimatedSprite2D.play("idle")
	
	


func handle_atack_animation(punch):
	$AnimatedSprite2D.play(punch)


func _input(event):
		
	if event.is_action_pressed("speedplayer"):
		move_speed += 100
	if event.is_action_released("speedplayer"):
		move_speed -= 100
	

func player():
	pass

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_atack_range = true

func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_atack_range = false
		

func enemy_atack():
	if enemy_in_atack_range and enemy_atack_cooldwon == true:
		health = health - 20
		enemy_atack_cooldwon = false
		$atack_cooldwon.start()
		print(health)


func _on_atackcooldwon_timeout() -> void:
	enemy_atack_cooldwon = true
