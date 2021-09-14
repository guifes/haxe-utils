package guifes.openfl.extension;

import openfl.geom.Point;

class PointExtension
{
	static public function distanceTo(self: Point, target: Point)
	{
		return target.subtract(self).length;
	}
}
