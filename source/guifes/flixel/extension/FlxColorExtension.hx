package guifes.flixel.extension;

import flixel.util.FlxColor;

class FlxColorExtension
{
	static public function toFloatArray(self: FlxColor): Array<Float>
	{
		return [self.redFloat, self.greenFloat, self.blueFloat, self.alphaFloat];
	}
}
