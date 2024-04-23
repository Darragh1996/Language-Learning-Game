extends Node
# WordInfo = [irishWord, Power, [Meaning/Context], timesEncountered]

enum {
	Éan,
	Dubh,
	Gorm,
	Leabhar,
	Buachaill,
	Féileacán,
	Cathoir,
	Páistí,
	Bó,
	Lá,
	Fia,
	Madra,
	Doras,
	Súil,
	Aghaidh,
	Teaghlach,
	Cosa,
	Iasc,
	Cúig,
	Bia,
	Sionnach,
	Cailín,
	Glas,
	Lámh,
	Ceann,
	Teach,
	Capall,
	Solas,
	Fear,
	Máthair,
	Sliabh,
	Luch,
	Oíche,
	Uimhir,
	Leathanach,
	Daoine,
	Pictiúr,
	Planda,
	Coinín,
	Dearg,
	Abhainn,
	Fuaim,
	Bord,
	Am,
	Crann,
	Fuinneog,
	Uisce,
	Bán,
	Bean,
	Focal,
	Bliain,
	Buí
}

var WORDS = {
	Éan: ["éan", 1, ["bird"], 0],
	Dubh: ["dubh", 1, ["black"], 0],
	Gorm: ["gorm", 1, ["blue"], 0],
	Leabhar: ["leabhar", 1, ["book"], 0],
	Buachaill: ["buachaill", 1, ["boy"], 0],
	Féileacán: ["féileacán", 1, ["butterfly"], 0],
	Cathoir: ["cathoir", 1, ["chair"], 0],
	Páistí: ["páistí", 1, ["children"], 0],
	Bó: ["bó", 1, ["cow"], 0],
	Lá: ["lá", 1, ["day"], 0],
	Fia: ["fia", 1, ["deer"], 0],
	Madra: ["madra", 1, ["dog"], 0],
	Doras: ["doras", 1, ["door"], 0],
	Súil: ["súil", 1, ["eye"], 0],
	Aghaidh: ["aghaidh", 1, ["face"], 0],
	Teaghlach: ["teaghlach", 1, ["family"], 0],
	Cosa: ["cosa", 1, ["feet"], 0],
	Iasc: ["iasc", 1, ["fish"], 0],
	Cúig: ["cúig", 1, ["five"], 0],
	Bia: ["bia", 1, ["food"], 0],
	Sionnach: ["sionnach", 1, ["fox"], 0],
	Cailín: ["cailín", 1, ["girl"], 0],
	Glas: ["glas", 1, ["green"], 0],
	Lámh: ["lámh", 1, ["hand"], 0],
	Ceann: ["ceann", 1, ["head"], 0],
	Teach: ["teach", 1, ["house"], 0],
	Capall: ["capall", 1, ["horse"], 0],
	Solas: ["solas", 1, ["light"], 0],
	Fear: ["fear", 1, ["man"], 0],
	Máthair: ["máthair", 1, ["mother"], 0],
	Sliabh: ["sliabh", 1, ["mountain"], 0],
	Luch: ["luch", 1, ["mouse"], 0],
	Oíche: ["oíche", 1, ["night"], 0],
	Uimhir: ["uimhir", 1, ["number"], 0],
	Leathanach: ["leathanach", 1, ["page"], 0],
	Daoine: ["daoine", 1, ["people"], 0],
	Pictiúr: ["pictiúr", 1, ["picture"], 0],
	Planda: ["planda", 1, ["plant"], 0],
	Coinín: ["coinín", 1, ["rabbit"], 0],
	Dearg: ["dearg", 1, ["red"], 0],
	Abhainn: ["abhainn", 1, ["river"], 0],
	Fuaim: ["fuaim", 1, ["sound"], 0],
	Bord: ["bord", 1, ["table"], 0],
	Am: ["am", 1, ["time"], 0],
	Crann: ["crann", 1, ["tree"], 0],
	Fuinneog: ["fuinneog", 1, ["window"], 0],
	Uisce: ["uisce", 1, ["water"], 0],
	Bán: ["bán", 1, ["white"], 0],
	Bean: ["bean", 1, ["woman"], 0],
	Focal: ["focal", 1, ["word"], 0],
	Bliain: ["bliain", 1, ["year"], 0],
	Buí: ["buí", 1, ["yellow"], 0],
}

var discoveredWords : Array = []

func get_random() -> Array:
	var size : int = WORDS.size()
	var random_key : int = WORDS.keys()[randi() % size]
	var word = WORDS[random_key]
	WORDS.erase(random_key)
	return word

func compare_words(a, b) -> bool:
	if a[3] < b[3]:
		return true
	elif a[3] > b[3]:
		return false
		
	if a[1] > b[1]:
		return true
	elif a[1] > b[1]:
		return false
		
	return false

func add_word(newWord: Array) -> void:
	
	discoveredWords.append(newWord)
	print("before sorting:")
	print(discoveredWords)
	print("=======================")
	discoveredWords.sort_custom(compare_words)
	print("after sorting:")
	print(discoveredWords)
	print("=======================")

func get_word(targetWord: String) -> Array:
	for val in WORDS.values():
		if val[0] == targetWord:
			return val
	return []

func get_discovered_word(targetWord: String) -> Array:
	for word in discoveredWords:
		if word[0] == targetWord:
			return word
	return []

func update_word_damage(targetWord: String, val: int) -> void:
	for word in discoveredWords:
		if word[0] == targetWord:
			word[3] += 1 # updates times encountered
			word[1] += val
			if word[1] <= 0:
				word[1] = 1
			elif word[1] > 9:
				word[1] = 9
	discoveredWords.sort_custom(compare_words)
