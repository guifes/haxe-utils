package guifes.openfl.extension;

import openfl.display.DisplayObjectContainer;
import openfl.geom.Point;

class DisplayObjectContainerExtension
{
	static public function centerX(self: DisplayObjectContainer, value: Float)
	{
		return self.x = value - (self.width * 0.5);
	}

	static public function centerY(self: DisplayObjectContainer, value: Float)
    {
        return self.y = value - (self.height * 0.5);
    }

	static public function center(self: DisplayObjectContainer): Point
	{
		return new Point(self.x + self.width * 0.5, self.y + self.height * 0.5);
	}
}
