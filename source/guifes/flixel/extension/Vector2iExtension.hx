package guifes.flixel.extension;

import guifes.math.Vector2i;
import flixel.math.FlxPoint;

class Vector2iExtension
{
	static public function toPoint(vector: Vector2i): FlxPoint
	{
		return new FlxPoint(vector.x, vector.y);
	}
}
