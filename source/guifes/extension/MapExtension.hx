package guifes.extension;

import haxe.ds.Map;

class MapExtension
{
	static public function valuesToArray<K,V>(self: Map<K,V>): Array<V>
	{
        return [ for(value in self.iterator()) value ];
	}
}
