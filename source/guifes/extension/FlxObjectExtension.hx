package extension;

import flixel.FlxObject;

class FlxObjectExtension
{
	static public function setMidpoint(obj: FlxObject, x: Float, y: Float)
	{
		obj.setPosition(x - (obj.width * 0.5), y - (obj.height * 0.5));

		return obj.getPosition();
	}
}
