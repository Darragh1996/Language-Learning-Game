extends TextureRect

var status : String = "default"
var tween : Tween
var targetColor : Color = Color(1, 1, 1)

func setStatus(statusFlag : String):
	status = statusFlag
	
func changeColour() -> void:
	if status == "correct":
		targetColor = Color(0.384, 0.722, 0.208)
	elif status == "incorrect":
		targetColor = Color(0.988, 0, 0.035)
	else:
		targetColor = Color(1, 1, 1)
	
	tween = create_tween()
	if tween:
		tween.tween_property(self, "modulate", targetColor, 1.0)
