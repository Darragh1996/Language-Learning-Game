extends Node2D

var cardScene = preload("res://Scenes/Word_Card.tscn")

func _ready() -> void:
	var WordDatabase : Object = preload("res://Words/word_list.gd").new()
	for i in range(1):
		var CardInfo : Array = WordDatabase.WORDS[i]
		var card_instance = cardScene.instantiate()
		card_instance.initialize_card(CardInfo)
		%CardHand.add_child(card_instance)
