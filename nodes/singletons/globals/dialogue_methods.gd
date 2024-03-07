# Is an autoload so that DialogueManager can detect it and use it. 
extends Node

var vowels: PackedStringArray = [
	"a", 
	"e", 
	"i", 
	"o", 
	"u"
]

func starts_with_vowel(word: String) -> bool: 
	var first_letter: String = word.substr(0, 1).to_lower()
	if first_letter in vowels: 
		return true
	return false
	
	
	
