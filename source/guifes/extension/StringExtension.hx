package guifes.extension;

using StringTools;

class StringExtension
{
	public static inline function contains(s:String, str:String):Bool
    {
        return s.indexOf(str) != -1;
    }

	public static inline function remove(s: String, sub: String): String
	{
		return s.replace(sub, "");
	}
}