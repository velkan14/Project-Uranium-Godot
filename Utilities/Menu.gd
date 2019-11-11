extends Node2D

var current
var input = false
var open = false
var menu = false

var offscreen_left = 556
var offscreen_right = -44
var init_pos
var saving = false

var move_offset


enum ORDER {
	PARTY,
	BAG,
	POKEPOD,
	CARD,
	SAVE,
	OPTION,
	EXIT,
	POKEDEX
}

func _ready():
	current = ORDER.PARTY
	init_pos = $Option_Text.rect_position
	
	$Save_Menu/Info/Player_Name/Name.bbcode_text = "[right]" + Global.TrainerName + "[/right]"

func _input(event):
	if open and !menu:
		if event.is_action_pressed("ui_left") and input == false and !saving:
			input = true
			move_sprites("Left")
			yield(get_tree().create_timer(0.6), "timeout")
			input = false
		elif event.is_action_pressed("ui_right") and input == false and !saving:
			input = true
			move_sprites("Right")
			yield(get_tree().create_timer(0.6), "timeout")
			input = false
		elif event.is_action_pressed("z") and input == false and !saving:
			input = true
			Global.sprint = !Global.sprint
			if $Run/Sprite.frame == 0:
				$Run/Sprite.frame = 1
			else:
				$Run/Sprite.frame = 0
			yield(get_tree().create_timer(0.3), "timeout")
			input = false
		elif event.is_action_pressed("interact"):
			menu = true
		
	elif menu:
		select()
		
		pass

func select():
	if current == ORDER.SAVE:
		if !saving:
			yield(get_tree().create_timer(0.3), "timeout")
		saving = true
		$Save_Menu.visible = true
		$Yes_no.visible = true
		
		if Input.is_action_pressed("ui_down") and saving:
			if $Yes_no/Box/Cursor.position.y == 32:
				$Yes_no/Box/Cursor.position.y = 64
				yield(get_tree().create_timer(0.3), "timeout")
			else:
				pass
		elif Input.is_action_pressed("ui_up") and saving:
			if $Yes_no/Box/Cursor.position.y == 64:
				$Yes_no/Box/Cursor.position.y -= 32
				yield(get_tree().create_timer(0.3), "timeout")
			else:
				pass
		
		if Input.is_action_pressed("interact"):
			if $Yes_no/Box/Cursor.position.y == 32:
				print("Saved")
				yield(get_tree().create_timer(0.2), "timeout")
				SaveSystem.save_game(1)
			else:
				$Yes_no.visible = false
				$Save_Menu.visible = false
				saving = false
				menu = false
				yield(get_tree().create_timer(0.3), "timeout")
				$Yes_no/Box/Cursor.position.y = 32
	else:
		pass

func move_sprites(dir):
	if dir == "Left":
		current -= 1
		
		if current == -1:
			current = 7
		
	else:
		current += 1
		
		if current == 8:
			current = 0
		
	
	if current == ORDER.PARTY:
		$Option_Text.rect_position = init_pos
		$Option_Text.bbcode_text = "POKÉMON"
		
		grey_frame()
		$"Options/PARTY/Pokémon".frame = 1
	elif current == ORDER.BAG:
		$Option_Text.rect_position.x = init_pos.x + 22
		$Option_Text.bbcode_text = "BAG"
		
		grey_frame()
		$Options/BAG/Bag.frame = 1
	elif current == ORDER.POKEPOD:
		$Option_Text.rect_position.x = init_pos.x - 2
		$Option_Text.bbcode_text = "POKEPOD"
		
		grey_frame()
		$"Options/POKEPOD/Poképod".frame = 1
	elif current == ORDER.CARD:
		$Option_Text.rect_position.x = init_pos.x - 24
		$Option_Text.bbcode_text = "TRAINERCARD"
		
		grey_frame()
		$Options/CARD/Card.frame = 1
	elif current == ORDER.SAVE:
		$Option_Text.rect_position.x = init_pos.x + 16
		$Option_Text.bbcode_text = "SAVE"
		
		grey_frame()
		$Options/SAVE/Save.frame = 1
	elif current == ORDER.OPTION:
		$Option_Text.rect_position = init_pos
		$Option_Text.bbcode_text = "OPTIONS"
		
		grey_frame()
		$Options/OPTION/Options.frame = 1
	elif current == ORDER.EXIT:
		$Option_Text.rect_position.x = init_pos.x + 16
		$Option_Text.bbcode_text = "EXIT"
		
		grey_frame()
		$Options/EXIT/Exit.frame = 1
	elif current == ORDER.POKEDEX:
		$Option_Text.rect_position = init_pos
		$Option_Text.bbcode_text = "POKEDEX"
		
		grey_frame()
		$Options/POKEDEX/Pokedex.frame = 1
	
	slide(dir)

func slide(dir):
	if dir == "Left":
		for node in get_child(5).get_children():
			if node.position.x > 512:
				node.position.x = offscreen_right
		
		move_offset = Vector2(38 * 2, 0)
	else:
		for node in get_child(5).get_children():
			if node.position.x < 0:
				node.position.x = offscreen_left
		
		move_offset = -Vector2(38 * 2, 0)
		
	$Options/PARTY/Tween.interpolate_property($Options/PARTY, "position", $Options/PARTY.position, $Options/PARTY.position + move_offset, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Options/BAG/Tween.interpolate_property($Options/BAG, "position", $Options/BAG.position, $Options/BAG.position + move_offset, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Options/POKEPOD/Tween.interpolate_property($Options/POKEPOD, "position", $Options/POKEPOD.position, $Options/POKEPOD.position + move_offset, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Options/CARD/Tween.interpolate_property($Options/CARD, "position", $Options/CARD.position, $Options/CARD.position + move_offset, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Options/SAVE/Tween.interpolate_property($Options/SAVE, "position", $Options/SAVE.position, $Options/SAVE.position + move_offset, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Options/OPTION/Tween.interpolate_property($Options/OPTION, "position", $Options/OPTION.position, $Options/OPTION.position + move_offset, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Options/EXIT/Tween.interpolate_property($Options/EXIT, "position", $Options/EXIT.position, $Options/EXIT.position + move_offset, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Options/POKEDEX/Tween.interpolate_property($Options/POKEDEX, "position", $Options/POKEDEX.position, $Options/POKEDEX.position + move_offset, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN)
	
	$Options/PARTY/Tween.start()
	$Options/BAG/Tween.start()
	$Options/POKEPOD/Tween.start()
	$Options/CARD/Tween.start()
	$Options/SAVE/Tween.start()
	$Options/OPTION/Tween.start()
	$Options/EXIT/Tween.start()
	$Options/POKEDEX/Tween.start()
	
	
	yield($Options/POKEDEX/Tween, "tween_completed")
	
	
	
	

func grey_frame():
	
	$"Options/PARTY/Pokémon".frame = 0
	$"Options/POKEPOD/Poképod".frame = 0
	$Options/BAG/Bag.frame = 0
	$Options/CARD/Card.frame = 0
	$Options/OPTION/Options.frame = 0
	$Options/POKEDEX/Pokedex.frame = 0
	$Options/SAVE/Save.frame = 0
	$Options/EXIT/Exit.frame = 0