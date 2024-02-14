extends Control

func select():
	for child in get_tree().get_nodes_in_group("card_zone"):
		child.deselect()
	modulate = Color.WEB_MAROON
		
func deselect():
	modulate = Color.WHITE
