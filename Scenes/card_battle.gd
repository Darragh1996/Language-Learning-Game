extends Control

var wordCard = preload("res://Scenes/word_card.tscn")
var pictureCard = preload("res://Scenes/picture_card.tscn")
var gems : Array
var numCards : int = 5
var damageTaken : int
var world_scene : PackedScene = preload("res://Scenes/world.tscn")
#var handCards : Array = []
var got_all_right = true
@onready var OppDropZones : Array = get_tree().get_nodes_in_group("opponent_card_drop_zones")
@onready var playerDropZones : Array = get_tree().get_nodes_in_group("player_card_drop_zone")

func _ready() -> void:
	randomize()
	gems = get_tree().get_nodes_in_group("status_gem")
	#var WordDatabase : Array = load_word_list()
	
	
	set_up_game()
	%PlayerHealthDisplay.text = "HP: " + str(PlayerData.get_health())
	

func set_up_game() -> void:
	var handCards : Array = []
	
	for dropZone in playerDropZones:
		dropZone.reset()
		
	for dropZone in OppDropZones:
		dropZone.reset()
	
	for i in range(numCards):
		#{
		#"irishWord": "éan",
		#"power": 1,
		#"meanings": [
			#"bird"
		#]
	#},
		#var CardInfo : Dictionary = WordDatabase[i]
		var CardInfo : Dictionary = {
			"irishWord": WordList.discoveredWords[i][0],
			"power": WordList.discoveredWords[i][1],
			"meanings":WordList.discoveredWords[i][2]
		}
		#print(CardInfo)
		handCards.append(CardInfo)
		
		var picture_card_instance = pictureCard.instantiate()
		picture_card_instance.initialize_card(CardInfo, false)
		#print(CardInfo)
		OppDropZones[i].add_child(picture_card_instance)
		
	handCards.shuffle()
	
	for i in range(len(handCards)):
		var word_card_instance = wordCard.instantiate()
		word_card_instance.initialize_card(handCards[i], true)
		%CardContainer.add_child(word_card_instance)

func load_word_list():
	#var filePath : String = "res://Words/word_list.json"
	#var file : FileAccess = FileAccess.open(filePath, FileAccess.READ)
	#var content = file.get_as_text()
	#var json = JSON.parse_string(content)
	#return json
	return DiscoveredWords.words


func _on_play_button_pressed() -> void:
	#var playerDropZones : Array = get_tree().get_nodes_in_group("player_card_drop_zone")
	var opponentDropZones : Array = get_tree().get_nodes_in_group("opponent_card_drop_zones")
	got_all_right = true
	damageTaken = 0
	for i in opponentDropZones.size():
		var opponentCardVal : String
		var playerCardVal : String
		if !opponentDropZones[i].vacant:
			for child in opponentDropZones[i].get_children():
				if child.is_in_group("cards"):
					opponentCardVal = child.word
					#print(opponentCardVal)
					
					if playerDropZones[i].vacant:
						gems[i].setStatus("incorrect")
						WordList.update_word_damage(opponentCardVal, 1)
						damageTaken += child.power
						got_all_right = false
					else:
						for child_p in playerDropZones[i].get_children():
							if child_p.is_in_group("cards"):
								playerCardVal = child_p.word
								if playerCardVal == opponentCardVal:
									gems[i].setStatus("correct")
									WordList.update_word_damage(opponentCardVal, -1)
								else:
									gems[i].setStatus("incorrect")
									WordList.update_word_damage(opponentCardVal, 1)
									damageTaken += child.power
									got_all_right = false
					#print(opponentCardVal)
					#print(WordList.get_discovered_word(opponentCardVal))
	PlayerData.take_damage(damageTaken)
	if PlayerData.get_health() > 0:
		%PlayerHealthDisplay.text = "HP: " + str(PlayerData.get_health())
	else:
		print("Game Over")
		get_tree().change_scene_to_file("res://Scenes/game_over_screen.tscn")
		return # prevent any other code from executing before the scene transition takes place
	
	for gem in gems:
		gem.changeColour()
	
	$Timer.start()

func _on_timer_timeout() -> void:
	if got_all_right:
		$Timer2.start()
	else:
		set_up_game()
		for gem in gems:
			gem.setStatus("")
			gem.changeColour()


func _on_timer_2_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
