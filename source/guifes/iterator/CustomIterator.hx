package guifes.iterator;

class CustomIterator
{
    public static function range(from: Int, upTo: Int, step: Int -> Int)
    {
        return new RangeIterator(from, upTo, step);
    }
}