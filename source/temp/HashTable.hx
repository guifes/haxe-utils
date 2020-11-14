package temp;

#if hl

import polygonal.ds.Hashable;
import haxe.ds.IntMap;

class HashTable<K: Hashable, T> //implements Map<K, T>
{
    private var _map: IntMap<Array<T>>;

    public function new(hashCapacity: Int)
    {
        _map = new IntMap<Array<T>>();
    }

    /**
		Stores all values that are mapped to `key` in `out` or returns 0 if `key` does not exist.
		@return the total number of values mapped to `key`.
	**/
	public function getAll(key: K, out: Array<T>): Int
    {
        var items = _map.get(key.key);
        if (items == null)
            return 0;
        else
        {
            out = items.copy();
            return items.length;
        }
    }

    /**
		Maps the value `val` to `key`.
		
		The method allows duplicate keys.
		<br/>To ensure unique keys either use `this.hasKey()` before `this.set()` or `this.setIfAbsent()`.
		@return true if `key` was added for the first time, false if another instance of `key` was inserted.
	**/
	public function set(key: K, val: T): Bool
    {
        if(key == null) {
            throw "Invalid key";
        }
        
        var keyAlreadyPresent: Bool = _map.exists(key.key);
        var array: Array<T> = keyAlreadyPresent ? _map.get(key.key) : new Array<T>();

        array.push(val);
        
        return keyAlreadyPresent;
    }
}

#end