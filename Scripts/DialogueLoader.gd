class_name Dialogue_Loader

"""
Takes a txt file and loads it into memory.
It can return the next piece of dialogue to user.
Two or more consecutive line breaks is used to split each item in txt file.
The first line of each new item must be the speaker's name.
"""

# Contains the dialogue to display
var _dialogue_list: Array[Dialogue];
# the index for the next to read Dialogue
var _curr_index: int;

""" 
The name of the txt file we will use to display the text.
Assumes the file is located in Text directory.
filename should be the path from Text directory to said txt file.
Error will be thrown if given file cannot be found
"""
# Parses given text file and stores results in _dialogue_list.
# Crashes if given file not found.
func _init(filename: String):
	var file_path: String = "res://Text/" + filename;
	_dialogue_list = [];
	_curr_index = 0;
	_parse_file(file_path);
	

	
# Reads through file and parses/stores content as follows:
# The first line of every new item will contain the name of the speaker
# followed by semi-colon.
# Every new item of text will be split by an empty line.
func _parse_file(file_path: String):
	assert(FileAccess.file_exists(file_path));
	var file: FileAccess = FileAccess.open(file_path, FileAccess.READ);
	var new_item: bool = true;
	var curr_text: String = "";
	var curr_speaker: String;
	# read/parse entire file
	while not file.eof_reached():
		var next_line: String = file.get_line();
		next_line.strip_edges();

		# we reached the end of a dialogue item.
		# add the newly read in dialogue item to _dialogue_list
		if next_line.is_empty():
			var new_dialogue: Dialogue = Dialogue.new(curr_speaker, curr_text);
			_dialogue_list.append(new_dialogue);
			new_item = true;
			continue;

		# If we're are first line of new dialogue item, then we know the line
		# contains the speaker of the dialogue item.
		# Else we are reading the contents of the dialogue
		if new_item:
			curr_text = "";
			curr_speaker = next_line;
			new_item = false;
		else:
			curr_text += next_line;
			
"""
Returns the next dialogue item in this.
Throws an error if user has read all dialogue.
"""
func get_next_dialogue() -> Dialogue:
	assert(_curr_index >= 0 and _curr_index < _dialogue_list.size());
	var next_dialogue: Dialogue = _dialogue_list[_curr_index];
	_curr_index += 1
	return next_dialogue;
	
"""
Returns true if user has read all dialogue.
Else return false.
"""
func dialogue_finished() -> bool:
	return _curr_index == _dialogue_list.size();
	
"""
Represents dialogue containing the speaker and what they're saying.
This is an immutable class.
"""
class Dialogue:
	# the speaker of this dialogue
	var _speaker: String;
	# the actual contents of the dialogue
	var _text: String;
	
	"""
	Init dialogue with given speaker and text string.
	Throws an error is speaker or text is null.
	"""
	func _init(speaker: String, text: String):
		assert(speaker != null);
		assert(text != null);
		_speaker = speaker;
		_text = text;

	"""returns the speaker of this dialogue"""
	func get_speaker() -> String:
		return _speaker;
		
	"""returns the actual content of this dialogue"""
	func get_text() -> String:
		return _text;
