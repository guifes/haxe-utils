package guifes.flixel.extension;

import guifes.math.Vector2i;
import flixel.math.FlxPoint;

class FlxPointExtension
{
	static public function fromVector2i(self: Class<FlxPoint>, vector: Vector2i): FlxPoint
	{
		return new FlxPoint(vector.x, vector.y);
	}
}
