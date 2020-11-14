package guifes.math;

class Trigonometry
{
    public static function tanh(t: Float): Float
    {
        var e_pt: Float = Math.exp(t);
        var e_nt: Float = Math.exp(-t);
        return (e_pt - e_nt) / (e_pt + e_nt);
    }

    public static function hypot(leg_a: Float, leg_b: Float): Float
    {
        var sq_leg_a = Math.pow(leg_a, 2);
        var sq_leg_b = Math.pow(leg_b, 2);
        return Math.sqrt(sq_leg_a + sq_leg_b);
    }
}