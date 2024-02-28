extends Node2D

var cardScene = preload("res://Scenes/Word_Card.tscn")

func _ready() -> void:
	var WordDatabase : Object = preload("res://Words/word_list.gd").new()
	var handCardZones = get_tree().get_nodes_in_group("hand_card_zones")
	var numCards : int = handCardZones.size()
	for i in range(numCards):
		var CardInfo : Array = WordDatabase.WORDS[i]
		var card_instance = cardScene.instantiate()
		card_instance.initialize_card(CardInfo)
		handCardZones[i].add_child(card_instance)
