extends Node


export(PackedScene) var pineapple_scene
export(PackedScene) var carrot_scene

var score = 0

func _ready():
	randomize()


#func _process(delta):
#	pass


func game_over():
	$Puke.play()
	$PineappleTimer.stop()
	$CarrotTimer.stop()
	$HUD.show_game_over()


func new_game():
	get_tree().call_group("food", "queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Was will die Zaza?")
	

func _on_Player_hit():
	game_over()


func _on_StartTimer_timeout():
	$PineappleTimer.start()
	$CarrotTimer.start()
	$HUD.update_score(score)


func _on_PineappleTimer_timeout():
	var pineapple = pineapple_scene.instance()
	
	var pineapple_spawn_location = get_node("MobPath/MobSpawnLocation")
	pineapple_spawn_location.offset = randi()
	
	var direction = pineapple_spawn_location.rotation + PI / 2
	
	pineapple.position = pineapple_spawn_location.position
	
	direction += rand_range(-PI / 4, PI / 4)
	pineapple.rotation = direction
	
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	pineapple.linear_velocity = velocity.rotated(direction)
	
	add_child(pineapple)


func _on_CarrotTimer_timeout():
	var carrot = carrot_scene.instance()
	
	var carrot_spawn_location = get_node("MobPath/MobSpawnLocation")
	carrot_spawn_location.offset = randi()
	
	var direction = carrot_spawn_location.rotation + PI / 2
	
	carrot.position = carrot_spawn_location.position
	
	direction += rand_range(-PI / 4, PI / 4)
	carrot.rotation = direction
	
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	carrot.linear_velocity = velocity.rotated(direction)
	
	add_child(carrot)


func _on_Player_eat():
	$Eat.play()
	score += 1
	$HUD.update_score(score)


