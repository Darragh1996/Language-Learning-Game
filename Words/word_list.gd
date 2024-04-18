extends Node
# WordInfo = [irishWord, Power, [Meaning/Context]]

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
	Teachlach,
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
	Éan: ["éan", 1, ["bird"]],
	Dubh: ["dubh", 1, ["black"]],
	Gorm: ["gorm", 1, ["blue"]],
	Leabhar: ["leabhar", 1, ["book"]],
	Buachaill: ["buachaill", 1, ["boy"]],
	Féileacán: ["féileacán", 1, ["butterfly"]],
	Cathoir: ["cathoir", 1, ["chair"]],
	Páistí: ["páistí", 1, ["children"]],
	Bó: ["bó", 1, ["cow"]],
	Lá: ["lá", 1, ["day"]],
	Fia: ["fia", 1, ["deer"]],
	Madra: ["madra", 1, ["dog"]],
	Doras: ["doras", 1, ["door"]],
	Súil: ["súil", 1, ["eye"]],
	Aghaidh: ["aghaidh", 1, ["face"]],
	Teachlach: ["teachlach", 1, ["family"]],
	Cosa: ["cosa", 1, ["feet"]],
	Iasc: ["iasc", 1, ["fish"]],
	Cúig: ["cúig", 1, ["five"]],
	Bia: ["bia", 1, ["food"]],
	Sionnach: ["sionnach", 1, ["fox"]],
	Cailín: ["cailín", 1, ["girl"]],
	Glas: ["glas", 1, ["green"]],
	Lámh: ["lámh", 1, ["hand"]],
	Ceann: ["ceann", 1, ["head"]],
	Teach: ["teach", 1, ["house"]],
	Capall: ["capall", 1, ["horse"]],
	Solas: ["solas", 1, ["light"]],
	Fear: ["fear", 1, ["man"]],
	Máthair: ["máthair", 1, ["mother"]],
	Sliabh: ["sliabh", 1, ["mountain"]],
	Luch: ["luch", 1, ["mouse"]],
	Oíche: ["oíche", 1, ["night"]],
	Uimhir: ["uimhir", 1, ["number"]],
	Leathanach: ["leathanach", 1, ["page"]],
	Daoine: ["daoine", 1, ["people"]],
	Pictiúr: ["pictiúr", 1, ["picture"]],
	Planda: ["planda", 1, ["plant"]],
	Coinín: ["coinín", 1, ["rabbit"]],
	Dearg: ["dearg", 1, ["red"]],
	Abhainn: ["abhainn", 1, ["river"]],
	Fuaim: ["fuaim", 1, ["sound"]],
	Bord: ["bord", 1, ["table"]],
	Am: ["am", 1, ["time"]],
	Crann: ["crann", 1, ["tree"]],
	Fuinneog: ["fuinneog", 1, ["window"]],
	Uisce: ["uisce", 1, ["water"]],
	Bán: ["bán", 1, ["white"]],
	Bean: ["bean", 1, ["woman"]],
	Focal: ["focal", 1, ["word"]],
	Bliain: ["bliain", 1, ["year"]],
	Buí: ["buí", 1, ["yellow"]],
}

var discoveredWords : Array = []

func get_random() -> Array:
	var size : int = WORDS.size()
	var random_key : int = WORDS.keys()[randi() % size]
	var word = WORDS[random_key]
	WORDS.erase(random_key)
	return word

func add_word(newWord: Array) -> void:
	discoveredWords.append(newWord)

func get_word(targetWord: String) -> Array:
	for val in WORDS.values():
		if val[0] == targetWord:
			return val
	return []
