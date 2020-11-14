package temp;

#if hl

import haxe.ds.IntMap;

class IntHashSet
{
    private var _map: IntMap<Bool>;

    public function new(slotCount: Int)
    {
        _map = new IntMap<Bool>();
    }

    /**
		Same as `this.has()`.
	**/
	public inline function contains(val: Int): Bool
    {
        return _map.exists(val);
    }

    /**
		Adds `val` to this set if possible.
		@return true if `val` was added to this set, false if `val` already exists.
	**/
    public inline function set(val: Int): Bool
    {
        if(_map.exists(val))
        {
            return false;
        }
        else
        {
            _map.set(val, true);
            return true;
        }
    }
}

#end