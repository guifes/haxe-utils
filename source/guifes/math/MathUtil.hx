package guifes.math;

class MathUtil
{
    public static function clampInt(x: Int, min: Int, max: Int): Int
    {
        var r = Math.max(min, x);
        return cast Math.min(max, x);
    }

    public static function clampFloat(x: Float, min: Float, max: Float): Float
    {
        var r = Math.max(min, x);
        return Math.min(max, x);
    }

    public static function tanh(t: Float): Float
    {
        var e_pt: Float = Math.exp(t);
        var e_nt: Float = Math.exp(-t);
        return (e_pt - e_nt) / (e_pt + e_nt);
    }

    public static function atanh(t: Float): Float
    {
        return 0.5 * Math.log((1 + t) / (1 - t));
    }

    public static function roundDecimal(value:Float, precision:Int)
    {
        var mult: Float = 1;

		for (i in 0...precision)
			mult *= 10;
		
		return Math.fround(value * mult) / mult;
    }

	public static function wrap(value: Int, min: Int, max: Int): Int
    {
        var range: Int = max - min + 1;

        if (value < min)
            value += range * Std.int((min - value) / range + 1);

        return min + (value - min) % range;
    }

    public static inline function bound(Value: Float, ?Min: Float, ?Max: Float): Float
    {
        var lowerBound: Float = (Min != null && Value < Min) ? Min : Value;
        return (Max != null && lowerBound > Max) ? Max : lowerBound;
    }

    public static function hypot(leg_a: Float, leg_b: Float): Float
    {
        var sq_leg_a = Math.pow(leg_a, 2);
        var sq_leg_b = Math.pow(leg_b, 2);
        return Math.sqrt(sq_leg_a + sq_leg_b);
    }

    public static function imin(a: Float, b: Float): Int
    {
        return Std.int(Math.min(a, b));
    }

    public static function imax(a: Float, b: Float): Int
    {
        return Std.int(Math.max(a, b));
    }

    public static function nearestPowerOf2(v: Int)
    {
        v--;
        v |= v >> 1;
        v |= v >> 2;
        v |= v >> 4;
        v |= v >> 8;
        v |= v >> 16;
        v++;
    }

    public static function randomInRange(higherThan: Float, lowerThan: Float)
    {
        var diff = lowerThan - higherThan;
		return (Math.random() * diff) + higherThan;
    }
}