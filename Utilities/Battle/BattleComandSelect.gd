extends Node2D

var enabled = false
enum {ATTACK, BAG, POKE, RUN}
var selected = ATTACK

const ATTACK_POS = Vector2(76, 50)
const BAG_POS = Vector2(195, 50)
const POKE_POS = Vector2(315, 50)
const RUN_POS = Vector2(435, 50)
func start(name):
	$SelHand/AnimationPlayer.play("Squeez")
	$Prompt.bbcode_text = "[center]What will " + name + " do?"
	$Prompt/PromptShadow.bbcode_text = "[center]What will " + name + " do?"
	enabled = true
	
	$AttackLable.visible = true
	$BagLable.visible = false
	$PokeLable.visible = false
	$RunLable.visible = false
	$Attack/AnimationPlayer.play("Slide")
	
func _input(event):
	if event.is_action_pressed("ui_left") and enabled and selected != ATTACK:
		selected -= 1
		change_Sel_Hand_Pos()
	if event.is_action_pressed("ui_right") and enabled and selected != RUN:
		selected += 1
		change_Sel_Hand_Pos()
	
func change_Sel_Hand_Pos():
	match selected:
		ATTACK:
			$SelHand.position = ATTACK_POS
			$AttackLable.visible = true
			$BagLable.visible = false
			$PokeLable.visible = false
			$RunLable.visible = false
			
			$Bag.position = Vector2(195,70)
			$Poke.position = Vector2(315,70)
			$Run.position = Vector2(435,70)
			
			$Attack/AnimationPlayer.play("Slide")
			$Bag/AnimationPlayer.stop(true)
			$Poke/AnimationPlayer.stop(true)
			$Run/AnimationPlayer.stop(true)
		BAG:
			$SelHand.position = BAG_POS
			$AttackLable.visible = false
			$BagLable.visible = true
			$PokeLable.visible = false
			$RunLable.visible = false
			$Attack.position = Vector2(75,70)
			$Poke.position = Vector2(315,70)
			$Run.position = Vector2(435,70)
			$Attack/AnimationPlayer.stop(true)
			$Bag/AnimationPlayer.play("Slide")
			$Poke/AnimationPlayer.stop(true)
			$Run/AnimationPlayer.stop(true)
		POKE:
			$SelHand.position = POKE_POS
			$AttackLable.visible = false
			$BagLable.visible = false
			$PokeLable.visible = true
			$RunLable.visible = false
			$Attack.position = Vector2(75,70)
			$Bag.position = Vector2(195,70)
			$Run.position = Vector2(435,70)
			$Attack/AnimationPlayer.stop(true)
			$Bag/AnimationPlayer.stop(true)
			$Poke/AnimationPlayer.play("Slide")
			$Run/AnimationPlayer.stop(true)
		RUN:
			$SelHand.position = RUN_POS
			$AttackLable.visible = false
			$BagLable.visible = false
			$PokeLable.visible = false
			$RunLable.visible = true
			$Attack.position = Vector2(75,70)
			$Bag.position = Vector2(195,70)
			$Poke.position = Vector2(315,70)
			$Attack/AnimationPlayer.stop(true)
			$Bag/AnimationPlayer.stop(true)
			$Poke/AnimationPlayer.stop(true)
			$Run/AnimationPlayer.play("Slide")
	pass