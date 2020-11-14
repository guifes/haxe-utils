package temp;

#if hl

class ObjectPool<T>
{
    var _factory: Void->T;
    
    public function new(factory: Void->T) 
    {
        _factory = factory;
    }

    /**
		Gets an object from the pool; the method either creates a new object if the pool is empty (no object has been returned yet) or returns an existing object from the pool.
		To minimize object allocation, return objects back to the pool as soon as their life cycle ends.
	**/
	public inline function get(): T
    {
        return _factory();
    }
        
    /**
        Puts `obj` into the pool, incrementing `this.size`.
        
        Discards `obj` if the pool is full by passing it to the dispose function (`this.size` == `this.maxSize`).
    **/
    public inline function put(obj: T)
    {
        
    }
}

#end