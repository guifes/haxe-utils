package guifes.math;

import guifes.collection.IHashable;
import haxe.Serializer;
import haxe.Unserializer;

class Vector2i implements IComparable<Vector2i> implements IHashable
{
	public var x(default, null): Int;
	public var y(default, null): Int;
	public var magnitude(get, never): Float;
	public var inverse(get, never): Vector2i;

	public static var zero(get, never): Vector2i;
	public static var right(get, never): Vector2i;
	public static var left(get, never): Vector2i;
	public static var down(get, never): Vector2i;
	public static var up(get, never): Vector2i;
	public static var directions(get, never): Array<Vector2i>;

	public function new(x: Int, y: Int)
	{
		this.x = x;
		this.y = y;
	}

	private function get_magnitude(): Float
	{
		return MathUtil.hypot(x, y);
	}

	private function get_inverse(): Vector2i
	{
		return Vector2i.scale(this, -1);
	}

	private static function get_zero(): Vector2i
	{
		return new Vector2i(0, 0);
	}

	private static function get_right(): Vector2i
	{
		return new Vector2i(1, 0);
	}

	private static function get_left(): Vector2i
	{
		return new Vector2i(-1, 0);
	}

	private static function get_down(): Vector2i
	{
		return new Vector2i(0, 1);
	}

	private static function get_up(): Vector2i
	{
		return new Vector2i(0, -1);
	}

	private static function get_directions(): Array<Vector2i>
	{
		var transitions: Array<Vector2i> = new Array<Vector2i>();

		transitions.push(up);
		transitions.push(down);
		transitions.push(left);
		transitions.push(right);

		return transitions;
	}

	// Serialization

	@:keep
	function hxSerialize(s: Serializer)
	{
		s.serialize(x);
		s.serialize(y);
	}

	@:keep
	function hxUnserialize(u: Unserializer)
	{
		x = u.unserialize();
		y = u.unserialize();
	}

	// IComparable

	public function equals(param: Vector2i): Bool
	{
		return (x == param.x) && (y == param.y);
	}

	// IHashable

	public function hash(): String
	{
		return x + "," + y;
	}

	public function toString(): String
	{
		return "(" + x + ", " + y + ")";
	}

	// Static

	public static function add(param0: Vector2i, param1: Vector2i): Vector2i
	{
		return new Vector2i(param0.x + param1.x, param0.y + param1.y);
	}

	public static function subtract(param0: Vector2i, param1: Vector2i): Vector2i
	{
		return new Vector2i(param0.x - param1.x, param0.y - param1.y);
	}

	public static function scale(param: Vector2i, scale: Int): Vector2i
	{
		return new Vector2i(param.x * scale, param.y * scale);
	}
}
