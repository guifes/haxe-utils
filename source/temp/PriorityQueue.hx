package temp;

class PriorityQueue<T:(Prioritizable)>
{
    var _queue: Array<T>;
    var _inverse: Bool;

    public function new(initalCapacity: Null<Int> = 1, ?inverse: Null<Bool> = false)
    {
        _queue = new Array<T>();
        _inverse = inverse;
    }

    /**
		Enqueues `val`.
	**/
	public function enqueue(val: T)
    {
        var inserted: Bool = false;

        for(i in 0..._queue.length)
        {
            var item: T = _queue[i];

            if(
                (_inverse && (val.priority < item.priority)) ||
                (!_inverse && (val.priority > item.priority))
            )
            {
                val.position = i;
                _queue.insert(i, val);
                inserted = true;
                break;
            }
        }

        for(i in (val.position + 1)..._queue.length)
        {
            _queue[i].position = i;
        }

        if(!inserted)
        {
            val.position = _queue.length;
            _queue.push(val);
        }
    }
        
    /**
        Dequeues the front element.
    **/
    public function dequeue(): T
    {
        return _queue.shift();
    }
        
    /**
        Re-prioritizes `val`.
        @param priority the new priority.
    **/
    public function reprioritize(val: T, priority: Float): PriorityQueue<T>
    {
        _queue.splice(val.position, 1);

        val.priority = priority;

        enqueue(val);

        return this;
    }

    public function isEmpty(): Bool
    {
        return !(_queue.length > 0);
    }
}