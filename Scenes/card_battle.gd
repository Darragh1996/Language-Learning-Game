extends Control

var wordCard = preload("res://Scenes/word_card.tscn")
var pictureCard = preload("res://Scenes/picture_card.tscn")
var gems : Array

func _ready() -> void:
	gems = get_tree().get_nodes_in_group("status_gem")
	var WordDatabase : Array = load_word_list()
	var numCards : int = 5
	var OppDropZones : Array = get_tree().get_nodes_in_group("opponent_card_drop_zones")
	for i in range(numCards):
		var CardInfo : Dictionary = WordDatabase[i]
		var word_card_instance = wordCard.instantiate()
		word_card_instance.initialize_card(CardInfo, true)
		%CardContainer.add_child(word_card_instance)
		
		var picture_card_instance = pictureCard.instantiate()
		picture_card_instance.initialize_card(CardInfo, false)
		OppDropZones[i].add_child(picture_card_instance)
		
func load_word_list():
	var filePath : String = "res://Words/word_list.json"
	var file = FileAccess.open(filePath, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.parse_string(content)
	return json


func _on_play_button_pressed() -> void:
	var playerDropZones : Array = get_tree().get_nodes_in_group("player_card_drop_zone")
	var opponentDropZones : Array = get_tree().get_nodes_in_group("opponent_card_drop_zones")
	
	for i in opponentDropZones.size():
		var opponentCardVal : String
		var playerCardVal : String
		if !opponentDropZones[i].vacant:
			for child in opponentDropZones[i].get_children():
				if child.is_in_group("cards"):
					opponentCardVal = child.word
					
					if playerDropZones[i].vacant:
						gems[i].setStatus("incorrect")
					else:
						for child_p in playerDropZones[i].get_children():
							if child_p.is_in_group("cards"):
								playerCardVal = child_p.word
								if playerCardVal == opponentCardVal:
									gems[i].setStatus("correct")
								else:
									gems[i].setStatus("incorrect")
									
	for gem in gems:
		gem.changeColour()
