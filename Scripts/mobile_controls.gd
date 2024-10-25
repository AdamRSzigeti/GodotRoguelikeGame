extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gui.Hide_Controls.connect(HideControls)
	Gui.Show_Controls.connect(ShowControls)

func HideControls():
	self.visible = false

func ShowControls():
	self.visible = true
