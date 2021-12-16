package guifes.openfl.extension;

import openfl.text.TextField;
import openfl.text.TextFormat;

using guifes.extension.StringExtension;

typedef TextFormatMarkerPair = {
	format: TextFormat,
	marker: String
};

class TextFieldExtension
{
	public static function applyMarkup(self: TextField, input: String, rules: Array<TextFormatMarkerPair>)
	{
		if(rules == null || rules.length == 0)
			return; // there's no point in running the big loop

		self.setTextFormat(self.defaultTextFormat); // start with default formatting

		var rangeStarts: Array<Int> = [];
		var rangeEnds: Array<Int> = [];
		var rulesToApply: Array<TextFormatMarkerPair> = [];

		var i: Int = 0;
		for(rule in rules)
		{
			if(rule.marker == null || rule.format == null)
				continue;

			var start: Bool = false;
			var markerLength: Int = rule.marker.length;

			if(!input.contains(rule.marker))
				continue; // marker not present

			// inspect each character
			for(charIndex in 0...input.length)
			{
				if(!(input.substr(charIndex, markerLength) == rule.marker))
					continue; // it's not one of the markers

				if(start)
				{
					start = false;
					rangeEnds.push(charIndex); // end a format block
				}
				else // we're outside of a format block
				{
					start = true; // start a format block
					rangeStarts.push(charIndex);
					rulesToApply.push(rule);
				}
			}

			if(start)
			{
				// we ended with an unclosed block, mark it as infinite
				rangeEnds.push(-1);
			}

			i++;
		}

		// Remove all of the markers in the string
		for(rule in rules)
			input = input.remove(rule.marker);

		// Adjust all the ranges to reflect the removed markers
		for(i in 0...rangeStarts.length)
		{
			// Consider each range start
			var delIndex: Int = rangeStarts[i];
			var markerLength: Int = rulesToApply[i].marker.length;

			// Any start or end index that is HIGHER than this must be subtracted by one markerLength
			for(j in 0...rangeStarts.length)
			{
				if(rangeStarts[j] > delIndex)
				{
					rangeStarts[j] -= markerLength;
				}
				if(rangeEnds[j] > delIndex)
				{
					rangeEnds[j] -= markerLength;
				}
			}

			// Consider each range end
			delIndex = rangeEnds[i];

			// Any start or end index that is HIGHER than this must be subtracted by one markerLength
			for(j in 0...rangeStarts.length)
			{
				if(rangeStarts[j] > delIndex)
				{
					rangeStarts[j] -= markerLength;
				}
				if(rangeEnds[j] > delIndex)
				{
					rangeEnds[j] -= markerLength;
				}
			}
		}

		// Apply the new text
		self.text = input;

		// Apply each format selectively to the given range
		for(i in 0...rangeStarts.length)
			self.setTextFormat(rulesToApply[i].format, rangeStarts[i], rangeEnds[i]);
	}
}