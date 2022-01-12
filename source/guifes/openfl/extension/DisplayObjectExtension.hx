package guifes.openfl.extension;

import openfl.display.DisplayObject;
import openfl.geom.Point;

class DisplayObjectExtension
{
	static public function centerX(self: DisplayObject, value: Float)
	{
		return self.x = value - (self.width * 0.5);
	}

	static public function centerY(self: DisplayObject, value: Float)
    {
        return self.y = value - (self.height * 0.5);
    }

	static public function center(self: DisplayObject): Point
	{
		return new Point(self.x + self.width * 0.5, self.y + self.height * 0.5);
	}
}
