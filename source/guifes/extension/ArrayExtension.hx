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
}