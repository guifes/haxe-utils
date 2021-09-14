package guifes.extension;

class ArrayExtension
{
	static public function has<T>(self: Array<T>, find: T -> Bool): Bool
	{
		for(item in self)
		if(find(item))
				return true;

		return false;
	}

	/**
	 * Returns the last element of an array or `null` if the array is `null` / empty.
	 */
	 public static function last<T>(array: Array<T>): Null<T>
	{
		if (array == null || array.length == 0)
			return null;

		return array[array.length - 1];
	}
}