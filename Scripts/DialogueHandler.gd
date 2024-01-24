extends Node

"""Finds the dialogue we want to display, and then deisplays that dialogue."""

"""The name of file containing the dialogue we want to display.
The filename will be relative to 'res://Text' directory.
Make sure to include '.txt' at the end of filename as well"""
@export var filename: String;

"""Label that will display the current speaker"""
@export var speaker: Label;
"""Label that will display what the speaker is currently saying"""
@export var text: Label;

var dialogue_list: Dialogue_Loader;

"""Loads the dialogue into memory"""
func _ready():
	dialogue_list = Dialogue_Loader.new(filename);
	var first_text: Dialogue_Loader.Dialogue = dialogue_list.get_next_dialogue();
	_display_dialogue(first_text);


"""If enter is pressed, display the next text item"""
func _process(_delta):
	var next: bool = Input.is_action_just_pressed("enter");
	if next and not dialogue_list.dialogue_finished():
		var next_text: Dialogue_Loader.Dialogue = dialogue_list.get_next_dialogue();
		_display_dialogue(next_text);
	elif next and dialogue_list.dialogue_finished():
		var finished_text: Dialogue_Loader.Dialogue = Dialogue_Loader.Dialogue.new("narrator", "finished");
		_display_dialogue(finished_text);
		

"""Given a Dialogue, display it's speaker and what they're saying in given labels"""
func _display_dialogue(dialogue: Dialogue_Loader.Dialogue):
	speaker.text = dialogue.get_speaker();
	text.text = dialogue.get_text();
