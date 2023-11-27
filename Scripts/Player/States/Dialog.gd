extends State

var player: Player
var dialog_box: RichTextLabel

func enter(_msg := {}):
	player = state_machine.player
	dialog_box = state_machine.dialog_box

func update(_delta):
	if !dialog_box.visible:
		state_machine.transition_to("Idle")
