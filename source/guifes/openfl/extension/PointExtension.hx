package guifes.openfl.extension;

import haxe.macro.Printer;
import openfl.geom.Point;
import guifes.math.Vector2i;

class PointExtension
{
	static public function distanceTo(self: Point, target: Point)
	{
		return target.subtract(self).length;
	}

	static public function fromVector2i(self: Class<Point>, source: Vector2i): Point
	{
		return new Point(source.x, source.y);
	}
}
