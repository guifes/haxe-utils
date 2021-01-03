package guifes.extension;

class StdExtension
{
	static public function randomFromRange(self: Class<Std>, min: Int, max: Int): Int
	{
        return min + Std.random(max - min + 1);
	}
}
