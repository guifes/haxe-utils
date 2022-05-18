package guifes.iterator;

class RangeIterator
{
	var i: Int;
    var upTo: Int;
    var step: Int -> Int;

	public inline function new(from: Int, upTo: Int, step: Int -> Int)
	{
		this.i = from;
        this.upTo = upTo;
        this.step = step;
	}

	public inline function hasNext()
		return i < upTo;

	public inline function next()
	{
        var v = i;
		i = step(i);
        return v;
	}
}