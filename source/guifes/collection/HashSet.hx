package guifes.collection;

import haxe.ds.StringMap;

class HashSet<K: (IHashable)>
{
	private var keys_map: StringMap<K>;
	private var keys_count: Int;

	public function new()
	{
		keys_map = new StringMap<K>();
		keys_count = 0;
	}

	// IMap implementation

	public function exists(k: K): Bool
	{
		return keys_map.exists(k.hash());
	}

	public function iterator(): Iterator<K>
	{
		return keys_map.iterator();
	}

	public function remove(k: K): Bool
	{
		return keys_map.remove(k.hash());
	}

	public function add(k: K): Void
	{
		if(!exists(k))
			keys_count++;
		
		keys_map.set(k.hash(), k);
	}

	public function count(): Int
	{
		return keys_count;
	}

	public function toString(): String
	{
		var output: String = "{ ";

		for(k in keys_map.keys())
		{
			output += "( " + k + " ) ";
		}

		output += "}";
		
		return output;
	}
}