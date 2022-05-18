package guifes.extension;

class ReverseArrayIterator<T>
{
	final arr: Array<T>;
	var i: Int;

	public inline function new(arr: Array<T>)
	{
		this.arr = arr;
		this.i = this.arr.length - 1;
	}

	public inline function hasNext()
		return i > -1;

	public inline function next()
	{
		return arr[i--];
	}
}

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

	public static inline function reversedValues<T>(arr: Array<T>)
	{
		return new ReverseArrayIterator(arr);
	}
}